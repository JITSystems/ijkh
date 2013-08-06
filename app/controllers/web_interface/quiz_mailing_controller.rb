# encoding: utf-8 
class WebInterface::QuizMailingController < WebInterfaceController
	#skip_before_filter :require_current_user
	def show
		@user = User.select("id, email, first_name").order("id ASC")

		@message = Message.new

		gb = Gibbon::API.new
		@campaigns = gb.campaigns.list({:start => 0, :limit => 100})
	    @lists = gb.lists.list({:start => 0, :limit=> 100})
	end


	def mailchimp
		gb = Gibbon::API.new
		
	  	@user = User.select("id, email, first_name").order("id ASC")

	  	@user.each do |user|

	  		unless WebInterface::QuizSession.where(user_id: user.id).first

		  		@quiz_token = SecureRandom.urlsafe_base64(nil, false)

				quiz_session_params = 
				{
					user_id: 		user.id,
					quiz_token: 	@quiz_token
				}

			   	WebInterface::QuizSession.create(quiz_session_params)

			else
				# place some action here
			end

			gb.lists.subscribe({:id => "5651d7d1b5", 
	    	:email => {
	    		:email => user.email }, 
	    		:merge_vars => {:FNAME => user.first_name, 
	    			:LNAME => '', 
	    			:QUIZT => @quiz_token
	    			}, 
	    			:double_optin => false})


		end




	    gb.campaigns.create({type: "regular", options: 
		    	{
	    		list_id: "5651d7d1b5", 
	    		subject: "Опрос клиентов АйЖКХ", 
	    		from_email: "feedback@izkh.ru", 
	    		from_name: "Сервис АйЖКХ", 
	    		generate_text: true
	    		}, 
		    	content: {html: "<html>
<head></head>
<body>
<p>Уважаемый(-ая) *|MERGE1|*!</p>

<p>Благодарим Вас за регистрацию на сервисе 'АйЖКХ'.</p>
<p>Мы стараемся сделать сервис удобнее для наших клиентов, поэтому нам очень важно знать Ваше мнение.</p>

<p>Пожалуйста, примите участие в коротком опросе.</p>
<p>Это займет у Вас не более 3-х минут.</p>
<br>
<p>
	<a style='position: relative;
	display: block;width: 300px;height: 40px;background-color: #0071bc;text-align: center;color: #FFF;
	font-size: 15px;font-weight: 600;cursor: pointer;text-decoration: none;line-height: 40px;'
	href='http://192.168.0.49:8080/quiz/*|QUIZT|*'>
		ПРИНЯТЬ УЧАСТИЕ В ОПРОСЕ
	</a>
</p>
<br>
<!-- <h1>Hi *|MERGE1|* *|MERGE2|* </h1>
<p>Your email is *|EMAIL|*</p>
<p>Do it yourself!</p> -->
</body>
</html>
"}
	    	})



	    respond_to do |format|
		format.js {
			render js: "console.log('Тест успешный.');"
				}
		end
		
	end

	 def create

	  	@user = User.select("id, email, first_name").order("id ASC")

	  	@user.each do |user|

	  		unless WebInterface::QuizSession.where(user_id: user.id).first

		  		@quiz_token = SecureRandom.urlsafe_base64(nil, false)

			  	message_params = {
					subject: 		"Опрос клиентов АйЖКХ",
					body: 			"Примите участие в коротком опросе",
					email: 			user.email,
					name: 			user.first_name,
					quiz_token: 	@quiz_token
				}

				quiz_session_params = 
				{
					user_id: 		user.id,
					quiz_token: 	@quiz_token
				}

			   	@message = Message.new(message_params)

			   	WebInterface::QuizSession.create(quiz_session_params)

			    if @message.valid?
			      QuizMailer.new_message(@message, user).deliver
			    else
			      flash.now.alert = "Всё плохо."
			      render :show
			    end

			    #respond_to do |format|
				# format.js {
				# 	render js: "console.log('Письмо отправлено: " + user.email.to_s + "');"
				# 		}
				# end

			else

				# respond_to do |format|
				# format.js {
				# 	render js: "console.log('Адрес найден: " + user.email.to_s + "');"
				# 		}
				# end

			end


		end

	end

end
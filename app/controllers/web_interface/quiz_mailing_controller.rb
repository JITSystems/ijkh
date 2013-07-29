# encoding: utf-8 

class WebInterface::QuizMailingController < WebInterfaceController

	skip_before_filter :require_current_user

		def show
			@user = User.select("id, email, first_name")

			@message = Message.new
		end

	 def create
	    
	  	@user = User.select("id, email, first_name").where("id = ?", 24)

	  	@user.each do |user|

	  		@quiz_token = SecureRandom.urlsafe_base64(nil, false)

		  	message_params = {
				subject: 		"Опрос клиентов АйЖКХ",
				body: 			"Lorem ipsum dolor.",
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

	   	end

	 end

end
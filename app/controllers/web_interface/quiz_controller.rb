# encoding: utf-8 

class WebInterface::QuizController < WebInterfaceController
	skip_before_filter :require_current_user

		

	def show

	# get 'quiz/:quiz_token' => 'web_interface/quiz#show'

		@quiz_session = WebInterface::QuizSession.select("user_id, last_question_id").where("quiz_token = ?", params[:quiz_token]).first

		@user = User.select("first_name, email").where("id = ?", @quiz_session.user_id).first

		@show_question = 0

		unless @quiz_session 
			redirect_to(root_path)
		end

		if @quiz_session.last_question_id 			

			if @quiz_session.last_question_id == 10
	  			redirect_to(root_path)
			else
				@show_question = @quiz_session.last_question_id
			end

		end


		@quiz_q = WebInterface::QuizQuestion.select("id, body, has_custom").order("id ASC")
		@quiz_a = WebInterface::QuizAnswer.select("id, body, quiz_question_id")

		@quiz = WebInterface::QuizResult.new(params[:quiz_result])

		@random_token = SecureRandom.urlsafe_base64(nil, false)

		@message = Message.new

	end

	def create
		# post 'quiz/:user_id' => 'web_interface/quiz#create'
		
	    @message = Message.new(params[:message])
	    
	    if @message.valid?
	      NotificationsMailer.new_message(@message).deliver
	      @message_success = "Сообщение успешно отправлено"
	      	respond_to do |format|
				format.js {
					render 'web_interface/quiz/feedback_success'
				}
			end

	    else
		    @message_error = "Пожалуйста, заполните все поля."
			respond_to do |format|
				format.js {
					render 'web_interface/quiz/feedback_error'
				}
			end
	    end
  	end




end
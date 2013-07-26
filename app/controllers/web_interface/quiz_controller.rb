# encoding: utf-8 

class WebInterface::QuizController < WebInterfaceController
	skip_before_filter :require_current_user

		

	def show

		@quiz_session = WebInterface::QuizSession.select("user_id, last_question_id").where("quiz_token = ?", params[:quiz_token]).first

		@show_question = 0

		#2013-07-25 13:01:30.638286

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

	end




end
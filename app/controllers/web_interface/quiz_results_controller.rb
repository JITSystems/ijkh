# encoding: utf-8 

class WebInterface::QuizResultsController < WebInterfaceController

	skip_before_filter :require_current_user

  def create
  	@counter = params[:web_interface_quiz_result][:quiz_question_id]
    @quiz = WebInterface::QuizResult.new(params[:web_interface_quiz_result])
    last_question_id = WebInterface::QuizSession.where("user_id = ?", params[:web_interface_quiz_result][:user_id]).first

    if @quiz.save
    	last_question_id.update_attributes(:last_question_id => @counter)
		respond_to do |format|
			format.js {
				render 'web_interface/quiz/next'
			}
		end
	else 
		@message = "Выберите вариант ответа."
		respond_to do |format|
			format.js {
				render 'web_interface/quiz/error'
			}
		end
	end

  end


end
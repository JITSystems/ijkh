# encoding: utf-8 

class WebInterface::QuizResultsController < WebInterfaceController

  def create
  	@counter = params[:web_interface_quiz_result][:quiz_question_id]

    @quiz = WebInterface::QuizResult.new(params[:web_interface_quiz_result].merge!(user_id: current_user.id))

    if @quiz.save
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
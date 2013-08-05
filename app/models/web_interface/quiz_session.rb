class WebInterface::QuizSession < ActiveRecord::Base
  attr_accessible :last_question_id, :quiz_token, :user_id
end

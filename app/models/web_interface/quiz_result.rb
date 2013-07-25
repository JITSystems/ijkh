class WebInterface::QuizResult < ActiveRecord::Base
  attr_accessible :custom_answer, :quiz_answer_id, :quiz_question_id, :user_id

  validates_presence_of :quiz_answer_id

  belongs_to :user
  belongs_to :quiz_question
  belongs_to :quiz_answer
end

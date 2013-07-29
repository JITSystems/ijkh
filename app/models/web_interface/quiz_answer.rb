class WebInterface::QuizAnswer < ActiveRecord::Base
  attr_accessible :body, :quiz_question_id

  belongs_to :quiz_question

  has_many :quiz_results
end

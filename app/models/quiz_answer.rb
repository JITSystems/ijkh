class QuizAnswer < ActiveRecord::Base
  attr_accessible :body, :quiz_question_id

  belongs_to :quiz_question, :dependent => :destroy
end

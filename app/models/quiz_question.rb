class QuizQuestion < ActiveRecord::Base
  attr_accessible :body

  has_many :quiz_answers
  has_many :quiz_results
end

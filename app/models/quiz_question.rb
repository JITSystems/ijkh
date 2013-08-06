class QuizQuestion < ActiveRecord::Base
  attr_accessible :body

  has_many :quiz_answers, :dependent => :destroy
  has_many :quiz_results, :dependent => :destroy
end

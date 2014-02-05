class FreelanceInterface::Comment < ActiveRecord::Base
  attr_accessible :body, :freelancer_id, :published, :raiting, :user_id

  validates :user_id, :body, :raiting, :presence => true

  belongs_to :freelancer
  belongs_to :user
end

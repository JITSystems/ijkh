class FreelanceInterface::Tag < ActiveRecord::Base
  attr_accessible :title, :published, :weight

  validates :title, :presence => true

  has_many :freelancers, :through => :freelancer_tags
  has_many :freelancer_tags
end

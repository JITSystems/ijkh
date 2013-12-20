class FreelanceInterface::Tag < ActiveRecord::Base
  attr_accessible :published, :title, :weight

  has_many :freelancers, :through => :freelancer_tags
  has_many :freelancer_tags
end

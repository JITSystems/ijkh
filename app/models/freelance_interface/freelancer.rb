class FreelanceInterface::Freelancer < ActiveRecord::Base
  attr_accessible :description, :name, :phone_number, :picture_url, :published, :raiting, :surname, :unpublish_at

  has_many :comments
  has_many :tags, :through => :freelancer_tags
  has_many :freelancer_tags
end

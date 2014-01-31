class FreelanceInterface::Freelancer < ActiveRecord::Base
  attr_accessible :description, :name, :phone_number, :picture_url, :published, :raiting, :surname, :unpublish_at, :user_id

  mount_uploader :picture_url, FreelanceInterfaceUploader

  has_many :comments
  has_many :tags, :through => :freelancer_tags
  has_many :freelancer_tags
  has_one :top_ten_freelancer
  has_one :top_four_freelancer
  belongs_to :user
end

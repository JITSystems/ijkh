class FreelanceInterface::Freelancer < ActiveRecord::Base
  attr_accessible :description, :name, :phone_number, :picture_url, :published, :raiting, :surname, :unpublish_at, :user_id, :service_id

  validates :name, :user_id, :phone_number, :presence => true
  validates :user_id, :uniqueness => true

  mount_uploader :picture_url, FreelanceInterfaceUploader

  has_many :comments
  has_many :tags, :through => :freelancer_tags
  has_many :freelancer_tags
  has_one :top_ten_freelancer
  has_many :top_four_freelancer

  belongs_to :service
  belongs_to :user
end

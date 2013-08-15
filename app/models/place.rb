class Place < ActiveRecord::Base
	extend PlacesRepository

  attr_accessible :apartment, :building, :city, :is_active, :street, :title, :user_id

  validates_presence_of :building, :city, :street, :title, :user_id

  belongs_to :user, foreign_key: :user_id

  has_many :services, conditions: "is_active is null or is_active != false"
  has_many :analytics
end

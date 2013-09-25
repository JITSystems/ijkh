class Place < ActiveRecord::Base
	extend PlacesRepository

  attr_accessible :apartment, :building, :city, :is_active, :street, :title, :user_id, :city_id

  validates_presence_of :building, :city, :street, :title, :user_id

  belongs_to :user, foreign_key: :user_id
  #belongs_to :city, foreign_key: :city_id

  has_many :services, conditions: "is_active = true"
  has_many :analytics
end

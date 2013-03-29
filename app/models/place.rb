class Place < ActiveRecord::Base
	extend PlacesRepository

  attr_accessible :apartment, :building, :city, :is_active, :street, :title, :user_id

  belongs_to :user, foreign_key: :user_id

  has_many :services, select: 'id, title, place_id, tariff_id, vendor_id, service_type_id, user_account'
end

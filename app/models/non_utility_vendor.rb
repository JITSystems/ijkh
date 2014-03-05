class NonUtilityVendor < ActiveRecord::Base
  attr_accessible :address, :description, :non_utility_service_type_id, :phone, :title, :work_time, :picture_url

  has_many :non_utility_tariffs, select: 'id, non_utility_vendor_id, title, description'
  has_many :non_utility_vendor_map_positions, select: 'id, non_utility_vendor_id, title, longitude, latitude'

  belongs_to :non_utility_service_type, select: 'id, title, description'

  has_many :non_utility_served_cities
  has_many :non_utility_vendors_contacts
  has_many :cities, through: :non_utility_served_cities
end
class NonUtilityVendor < ActiveRecord::Base
  attr_accessible :address, :description, :non_utility_service_type_id, :phone, :title, :work_time, :picture_url

  has_many :non_utility_tariffs
  has_many :non_utility_vendor_map_positions

  belongs_to :non_utility_service_type
end
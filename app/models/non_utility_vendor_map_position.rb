class NonUtilityVendorMapPosition < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :title, :non_utility_vendor_id

  belongs_to :non_utility_vendor, select: 'id, title, description, phone, work_time, address, non_utility_service_type_id, picture_url'
end

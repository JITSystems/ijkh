class NonUtilityTariff < ActiveRecord::Base
  attr_accessible :description, :non_utility_vendor_id, :title

  belongs_to :non_utility_vendor, select: 	'id, 
  											title,
  											description,
  											phone,
  											work_time,
  											address,
											non_utility_service_type_id,
  											picture_url'
end

class NonUtilityServiceType < ActiveRecord::Base
  attr_accessible :description, :title

  has_many :non_utility_vendors, select: 	'id,
  											title,
  											description,
											phone,
											work_time,
											address,
											non_utility_service_type_id,
											picture_url'
end

collection @non_utility_vendors

attributes :id, :title, :description, :address, :work_time, :phone, :picture_url

child :non_utility_vendor_map_positions do
	extends 'non_utility_vendor_map_position/index'
end

child :non_utility_tariffs do
	extends 'non_utility_tariff/index'
end
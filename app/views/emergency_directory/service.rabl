collection @emergency_services

attributes :id, :title, :emergency_district_id

child :emergency_infos do
	extends 'emergency_directory/info'
end
collection @emergency_categories

attributes :id, :title

child :emergency_services do
	extends 'emergency_directory/service'
end
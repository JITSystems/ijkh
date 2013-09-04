collection @emergency_districts

attributes :id, :title

child :emergency_services do
	extends 'emergency_directory/service'
end
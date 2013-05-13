collection @non_utility_service_types

attributes :id, :title

child :non_utility_vendors do
	extends 'non_utility_vendor/index'
end
collection @services

attributes :id, :title, :place_id, :service_type_id, :user_account

child :tariff do
	extends "tariff/show"
end

child :vendor do
	extends "vendor/show"
end
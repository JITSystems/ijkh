object @tariff

attributes :id, :title, :has_readings

child :fields do
	extends 'field/index'
end
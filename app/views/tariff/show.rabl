object @tariff

attributes :id, :title

child :fields do
	extends 'field/index'
end
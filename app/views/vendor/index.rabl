collection @vendors

attributes :id, :title

child :tariff_templates do
	extends 'tariff_template/index'
end
collection @vendors

attributes :id, :title, :merchant_id, :is_active

child :tariff_templates do
	extends 'tariff_template/index'
end
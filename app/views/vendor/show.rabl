object @vendor

attributes :id, :title, :merchant_id, :is_active, :inn

child :tariff_templates do
	extends 'tariff_templates/index'
end
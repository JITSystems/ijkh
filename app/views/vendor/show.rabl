object @vendor

attributes :id, :title, :merchant_id, :is_active, :inn

if @vendor
	child :tariff_templates do
		extends 'tariff_template/index'
	end
end
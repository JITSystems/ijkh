object @tariff_template

attributes :id, :title, :has_readings

child :field_templates do
	extends 'field_template/index'
end
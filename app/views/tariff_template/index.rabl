collection @tariff_templates

attributes :id, :title, :has_readings, :vendor_id

child :field_templates do
	extends 'field_template/index'
end
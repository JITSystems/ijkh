collection @field_templates

attributes :id, :title, :is_for_calc, :field_type, :value, :reading_field_title, :field_units

child :field_template_list_values do
	extends 'field_template_list_value/index'
end

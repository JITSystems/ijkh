collection @fields

attributes :id, :title, :field_type, :value, :reading_field_title, :is_for_calc

child :last_reading => :meter_readings do
	extends 'meter_reading/show'
end

child :field_list_values do
	extends 'field_template_list/index'
end
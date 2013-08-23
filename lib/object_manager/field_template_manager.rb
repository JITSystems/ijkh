class FieldTemplateManager < ObjectManager
	def self.create(params)
		# params hash:
		# 	title
		# 	value
		# 	is_for_calc
		# 	tariff_template_id
		# 	field_type
		# 	field_units
		field_template_params = {
								title: 				params[:title],
								value: 				params[:value],
								is_for_calc: 		params[:is_for_calc],
								tariff_template_id: params[:tariff_template_id],
								field_type: 		params[:field_type],
								field_units: 		params[:field_units]
								}
		return FieldTemplate.create!(field_template_params)
	end
end
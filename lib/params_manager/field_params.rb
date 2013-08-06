class FieldParams < ParamsManager

	def self.create(params, tariff)
		field_params(params, tariff)
	end

private

	def self.field_params(params, tariff)
		field_template = FieldTemplateManager.get(params[:id])

		f_p = {
				field_template_id: 		params[:id],
				tariff_id: 		   		tariff.id,
				is_for_calc: 	   		field_template.is_for_calc,
				title: 			   		field_template.title,
				value: 			   		field_template.value,
				field_units: 	   		field_template.field_units,
				reading_field_title: 	field_template.reading_field_title
			  }

		f_p
	end

end
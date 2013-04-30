module VendorsRepository

	def vendors_index service_type_id
		vendors = by_service_type(service_type_id).includes_child_data
		vendors = jsonify vendors
	end

	def by_service_type service_type_id
		where("service_type_id = ? and is_active = true", service_type_id)
	end

	def includes_child_data
		includes(
			tariff_templates:  
					{field_templates: :field_template_list_values}
				)
	end

	def jsonify vendors
		vendors.as_json(
			include: 
				{ tariff_template:
					{ include:
						{ field_templates:
							{ include:
								{field_template_list_values: {only: [:id, :value]}}
							}
						}
					}
				}						
			)
	end	
end
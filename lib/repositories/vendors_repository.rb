module VendorsRepository

	def vendors_index service_type_id
		vendors = by_service_type(service_type_id).includes_child_data
		vendors = jsonify vendors
		vendors = filter_values vendors
	end

	def by_service_type service_type_id
		where(service_type_id: service_type_id)
	end

	def includes_child_data
		includes(
			tariffs: 
				{ tariff_template: 
					{ field_templates: 
						[
						:values, 
						:field_template_list_values, 
						:reading_field_template, 
						:meter_readings
						]
					}
				})
	end

	def jsonify vendors
		vendors.as_json(
			include: 
				{ tariffs:
					{ include:
						{ tariff_template:
							{ include:
								{ field_templates:
									{ include:
										[
											{values: {only: [:id, :value, :tariff_id]}},
											{field_template_list_values: {only: [:id, :value]}}, 
											{reading_field_template: {only: [:id, :title]}}
										]
									}
								}
							}
						}
					}
				}						
			)
	end

	def filter_values vendors
		vendors.each do |vendor|
			tariffs = vendor[:tariffs]
			tariffs.each do |tariff|
				field_templates = tariff[:tariff_template][:field_templates]
				field_templates.each do |field_template|
					values = field_template[:values]
					values.delete_if do |value| 
						value["tariff_id"] != tariff["id"]
					end
					field_template.delete(:values)
					field_template[:value] = values
				end
			end
		end
	end
end
module ServicesRepository

	def create_service service, user, field_templates
		if new_service = Service.create!(service)
			new_service = jsonify new_service
			new_service = pack_data new_service, user, field_templates
		else
			{error: "something went wrong"}
		end
	end
	
	def jsonify service
		{ service: service.as_json(include: 
			                    	[{tariff: 
			                    		{ include: 
											{ tariff_template: 
												{ include: 
													{ field_templates: 
														{include: 
															[{values: {only: [:id, :value, :tariff_id]}},
															 {field_template_list_values: {only: [:id, :value]}}
															], only: [:id, :title, :is_for_calc]
														}
													}, only: [:id, :has_readings, :title]
												}
											}, only: [:title, :id, :owner_type]
										}
									}, vendor: {only: [:id, :title]} ]
								)
		}
	end

	def pack_data service, user, field_templates
		field_templates.each do |field_template|	
			if field_template[:meter_reading]
				meter_readings = field_template[:meter_reading]
			end
		end
		service[:service][:tariff][:tariff_template][:field_templates] = field_templates
		service
	end

	def existant_service_type_ids place_id
  		where(place_id: place_id).uniq.select("service_type_id as id").map(&:id)
  	end

  	def by_user_and_place current_user, place_id 
  		where('place_id = ? and user_id = ?',place_id , current_user.id) 
  	end

  	
end
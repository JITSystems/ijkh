module ServicesRepository

	def create_service service
		if new_service = Service.create!(service)
			new_service = jsonify new_service
			new_service = pack_data new_service
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
															 {field_template_list_values: {only: [:id, :value]}},
															 {meter_readings: {only: [:id, :reading, :created_at, :tariff_id, :value_id, :field_template_id]}}
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

	def pack_data service
		field_templates = service[:service][:tariff][:tariff_template][:field_templates]
		field_templates.each do |field_template|
			values = field_template[:values]
			field_template.delete(:values)

			if field_template[:meter_readings]
				meter_readings = field_template[:meter_readings]
				field_template.delete(:meter_readings)
			end

			values.delete_if 

			meter_readings.delete_if do |meter_reading|
				meter_reading["tariff_id"] != service[:service]["tariff_id"]
			end
		
			last_mr = meter_readings[0]					
					meter_readings.each do |mr|
						if last_mr["created_at"] < mr["created_at"]
							last_mr = mr
						end
					end
			meter_readings = last_mr
		
			field_template[:meter_reading] = meter_readings
			field_template[:value] = values.delete_if {|value| value["tariff_id"] != service[:service]["tariff_id"]}
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
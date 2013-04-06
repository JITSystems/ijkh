module PlacesRepository



	def new_place place
		if place = self.create!(place)
			place
		else
			place = {error: "something went wrong"}
		end
	end

	def deactivate place
		place_to_deactivate = self.find(place)
		if place_to_deactivate.update_attributes(is_active: false)
			services_to_destroy = Service.where(place_id: place)
			services_to_destroy.each do |service|
				Service.destroy_with_dependencies(service.id)
			end
			place_to_deactivate
		end
	end

	def update_place place, update
		logger.info update.inspect
		if update[:is_active] == "FALSE"
			place_to_update = deactivate place
		else
			place_to_update = self.find(place)
			if place_to_update.update_attributes(update)
				place_to_update
			else
				place_to_update = {error: "something went wrong"}
			end
		end
	end

	def places_index user
		if user then
			places = active_by_user(user).includes_child_data
			places = jsonify places
			places = pack_data places
			
			places
		else
			places = {error: "user not found"}
		end
	end

	def active_by_user user
		where("places.user_id = ? and is_active = ?", user.id, true)
	end

	def includes_child_data
		includes(services: 
					[:vendor, tariff: 
						{tariff_template: 
							{field_templates: 
								[
									:values, 
									:field_template_list_values, 
									:meter_readings
								]
							}
						}
					]
				)
	end

	private

	def jsonify places
		places.as_json(
					include: 
						{ services: 
		                    { include: 
		                    	[{tariff: 
		                    		{ include: 
										{ tariff_template: 
											{ include: 
												{ field_templates: 
													{include: 
														[{values: {only: [:id, :value, :tariff_id]}},
														 {field_template_list_values: {only: [:id, :value]}},
														 {meter_readings: {only: [:id, :reading, :created_at, :tariff_id, :value_id, :field_template_id, :snapshot_url]}}
														], only: [:id, :title, :is_for_calc]
													}
												}, only: [:id, :has_readings, :title]
											}
										}, only: [:title, :id, :owner_type]
									}
								}, vendor: {only: [:id, :title]} ]
							}
						}, only: [:title, :id, :city, :street, :building, :apartment] )
	end

	def pack_data places
		places.each do |place|
			services = place[:services]
			place.delete(:services)

			services.each do |service|
				field_templates = service[:tariff][:tariff_template][:field_templates]
				service[:tariff][:tariff_template].delete(:field_templates)				
				field_templates.each do |ft|
					values = ft[:values]
					if ft[:meter_readings]
						meter_readings = ft[:meter_readings]
						ft.delete(:meter_readings)	
					end
					ft.delete(:values)
					
					meter_readings.delete_if do |mr|
						mr["tariff_id"] != service["tariff_id"]
					end

					last_mr = meter_readings[0]					
					meter_readings.each do |mr|
						if last_mr["created_at"] < mr["created_at"]
							last_mr = mr
						end
					end
						meter_readings = last_mr

					ft[:meter_reading] = meter_readings
					ft[:value] = values.delete_if {|value| value["tariff_id"] != service["tariff_id"]}
				end
				service[:tariff][:tariff_template][:field_templates] = field_templates
			end
			place[:service] = services
		end
	end
end
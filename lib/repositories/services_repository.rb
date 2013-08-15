module ServicesRepository

	def get_title service_id
		service = Service.find(service_id)
		return service.title
	end

	def destroy_with_dependencies service_id
		service = find(service_id)
		
		if service.tariff.fields 
			service.tariff.fields.each do |field|
				field.destroy
			end
		end

		if service.tariff
			service.tariff.destroy
		end

		if service.account
			service.account.destroy
		end

		if service.meter_readings
			service.meter_readings.each do |meter_reading|
				meter_reading.destroy
			end
		end

		if service
			service.destroy
		end
		
		return {status: "deleted"}
	end

	def create_service user, params
		unless params[:service][:vendor].nil?
			create_predefined_service user, params
		else
			create_user_service user, params
		end
	end

	def update_user_service params
		fields_params = params[:service][:tariff][:fields]

		fields_params.each do |field_params|
			field = Field.find(field_params[:id])
			field.update_attributes(value: FloatModifier.substitute_comma(field_params[:value]).to_f)
		end
		service = find(params[:service_id])
	end

	def existant_service_type_ids place_id
  		where(place_id: place_id).uniq.select("service_type_id as id").map(&:id)
  	end

  	def by_user_and_place current_user, place_id 
  		where('place_id = ? and user_id = ?',place_id , current_user.id) 
  	end


  	private

   	def create_predefined_service user, params
  		service_params = {
				title: 				params[:service][:title],
				place_id: 			params[:place_id],
				service_type_id: 	params[:service][:service_type_id],
				vendor_id: 			params[:service][:vendor][:id],
				user_account: 		params[:service][:user_account],
				user_id: 			user.id,
				is_active: 			true
			}

		service = Service.new(service_params)

		if service.save
			
			params = params[:service]
			
			tariff_params = {
				title: 				params[:tariff][:title],
				tariff_template_id: params[:tariff][:id],
				owner_type: 		"Vendor",
				owner_id: 			params[:vendor][:id],
				has_readings: 		params[:tariff][:has_readings],
				service_type_id: 	params[:service_type_id],
				service_id: 		service.id
			}

			tariff = Tariff.new(tariff_params)
			
			account_params = {
				user_id: 			user.id,
				service_id: 		service.id,
				place_id:  			params[:place_id],
				status: 			1,
				amount: 			"0"
			}

			account = Account.new(account_params)

			account.save
			
			if tariff.save
				
				params = params[:tariff]
				
				params[:fields].each do |field_hash|
					# field_hash contains parameters comming from
					# client with data for field creation
					field_params = { 
						title: 					field_hash[:title],
						field_type: 			field_hash[:field_type],
						is_for_calc: 			field_hash[:is_for_calc],
						value: 					field_hash[:value],
						reading_field_title: 	field_hash[:reading_field_title],
						field_template_id: 		field_hash[:id],
						tariff_id: 				tariff.id,
						field_units: 			field_hash[:field_units]
					}

					field = Field.new(field_params)
					if field.save
						if field.is_for_calc == true
							meter_reading_hash = field_hash[:meter_readings]
							meter_reading_params = {
								reading: FloatModifier.substitute_comma(meter_reading_hash[:reading]).to_f,
								is_init: true,
								field_id: field.id,
								user_id: user.id,
								service_id: service.id
							}

							meter_reading = MeterReading.new(meter_reading_params)
							if meter_reading.save

							else
								return {error: "Failed to create meter reading"}
							end
						end
					else
						return {error: "Failed to create field"}
					end
				end

			else
				return {error: "Failed to create tariff"}
			end
		else
			return {error: "Failed to create service"}
		end
		service = Service.find(service.id)
		return service

  	end

  	def create_user_service user, params

  	service_params = {
				title: 				params[:service][:title],
				place_id: 			params[:place_id],
				service_type_id: 	params[:service][:service_type_id],
				user_id: 			user.id,
				is_active: 			true
			}

		service = Service.new(service_params)

		if service.save
			
			params = params[:service]
			
			tariff_params = {
				title: 				params[:tariff][:title],
				tariff_template_id: params[:tariff][:id],
				owner_type: 		"User",
				owner_id: 			user.id,
				has_readings: 		params[:tariff][:has_readings],
				service_type_id: 	params[:service_type_id],
				service_id: 		service.id
			}

			tariff = Tariff.new(tariff_params)
			
			account_params = {
				user_id: 			user.id,
				service_id: 		service.id,
				place_id:  			params[:place_id],
				status: 			1,
				amount: 			"0"
			}

			account = Account.new(account_params)

			account.save
			
			if tariff.save
				
				params = params[:tariff]
				
				params[:fields].each do |field_hash|
					# field_hash contains parameters comming from
					# client with data for field creation
					field_params = { 
						title: 					field_hash[:title],
						field_type: 			field_hash[:field_type],
						is_for_calc: 			field_hash[:is_for_calc],
						value: 					FloatModifier.substitute_comma(field_hash[:value]).to_f,
						reading_field_title: 	field_hash[:reading_field_title],
						field_template_id: 		field_hash[:id],
						tariff_id: 				tariff.id,
						field_units: 			field_hash[:field_units]
					}

					field = Field.new(field_params)
					if field.save
						if field.is_for_calc == true
							meter_reading_hash = field_hash[:meter_readings]
							meter_reading_params = {
								reading: FloatModifier.substitute_comma(meter_reading_hash[:reading]).to_f,
								is_init: true,
								field_id: field.id,
								user_id: user.id,
								service_id: service.id
							}

							meter_reading = MeterReading.new(meter_reading_params)
							if meter_reading.save

							else
								return {error: "Failed to create meter reading"}
							end
						end
					else
						return {error: "Failed to create field"}
					end
				end

			else
				return {error: "Failed to create tariff"}
			end
		else
			return {error: "Failed to create service"}
		end

		return service

  	end

end

class PredefinedService < Service
	#comment here
end

class UserService < Service
	
end
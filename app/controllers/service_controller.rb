class ServiceController < ApplicationController
	def index
		services = Service.by_user_and_place(current_user, params[:place_id])
		render json: services
	end

	def create
		if params[:service][:vendor]
			service = {
				title: 				params[:service][:title],
				tariff_id: 			params[:service][:tariff][:id],
				place_id: 			params[:place_id],
				service_type_id: 	params[:service][:service_type_id],
				vendor_id: 			params[:service][:vendor][:id],
				user_account: 		params[:service][:user_account],
				user_id: 			current_user.id
			}

			field_templates = params[:service][:tariff][:tariff_template][:field_templates]
			
			field_templates.each do |field_template|
			#logger.info field_template.inspect
				if field_template[:is_for_calc] == "1"
					meter_reading = {
						user_id: 			current_user.id,
						tariff_id: 			params[:service][:tariff][:id],
						value_id: 			field_template[:value].first[:id],
						reading: 			field_template[:meter_reading][:reading],
						is_init: 			true,
						field_template_id: 	field_template[:id]
					}

					meter_reading = MeterReading.new(meter_reading)
					meter_reading.save
					field_template[:meter_reading] = meter_reading
				end
			end
			service = Service.create_service service, current_user, field_templates
		end



		if service

			render json: service
		else
			render json: {error: "something went wrong"}
		end
	end

def create_user_service
		service = {
				title: 				params[:service][:title],
				place_id: 			params[:place_id],
				service_type_id: 	params[:service][:service_type_id],
				user_account: 		params[:service][:user_account],
				user_id: 			current_user.id
			}

		service = Service.new(service)

		if service.save
			tariff_template = params[:service][:tariff][:tariff_template]

			tariff = {
				owner_type: 			"User",
				owner_id: 				current_user.id,
				tariff_template_id: 	tariff_template[:id],
				title: 					tariff_template[:title]
			}

			tariff = Tariff.new(tariff)
			
			if tariff.save
				if tariff_template["field_templates"]
					field_templates = tariff_template["field_templates"]
					field_templates.each do |field_template|
						value = {
							tariff_id: 			tariff.id,
							field_template_id: 	field_template[:id],
							value: 				field_template[:value].first[:value]
						}
						value = Value.new(value)
						value.save

						if field_template[:is_for_calc] == "1"
							
							meter_reading = {
								user_id: 			current_user.id,
								tariff_id: 			params[:service][:tariff][:id],
								value_id: 			field_template[:value].first[:id],
								reading: 			field_template[:meter_reading][:reading],
								is_init: 			true,
								field_template_id: 	field_template[:id]
							}

							meter_reading = MeterReading.new(meter_reading)
							meter_reading.save
						end
					end
				end
			end
			service.update_attributes(tariff_id: tariff.id)
		end

		render json: service
	end


	def update_user_service
		field_templates = params[:service][:tariff][:tariff_template][:field_templates]
		field_templates.each do |field_template|
			
			value = Value.find((field_template[:value].first)[:id])
			value.update_attributes(field_template[:value].first)

		end
		
		service = Service.find(params[:service_id])
		render json: service
	end

	def destroy
		service = Service.find(params[:service_id])
		if service.destroy
			render json: {status: "deleted"}
		else
			render json: {error: "something went wrong"}
		end
	end

end
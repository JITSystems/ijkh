 class ServiceController < ApplicationController
	def index
		#@services = Service.by_user_and_place(current_user, params[:place_id])
		@services = Service.where("user_id=? and place_id=?", current_user.id, params[:place_id])
		render 'service/index'
	end

	def create
		if params[:service][:vendor]
			
			
			#logger.info params[:service][:tariff][:tariff_template][:field_templates]
			
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
	#	logger.info service.inspect
			field_templates.each do |field_template|
				if field_template[:is_for_calc] == "1"
					meter_reading_id = field_template[:meter_reading][:id]
					meter_reading = MeterReading.find(meter_reading_id)
					meter_reading.update_attributes(service_id: service[:service]["id"])
				end
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
						#logger.info value.inspect
						value = Value.new(value)
						value.save
						field_template[:value] = value.as_json(only: [:id, :value, :tariff_id])
						if field_template[:is_for_calc] == "1"
							
							meter_reading = {
								user_id: 			current_user.id,
								tariff_id: 			tariff.id,
								value_id: 			value.id,
								reading: 			field_template[:meter_reading][:reading],
								is_init: 			true,
								field_template_id: 	field_template[:id],
								service_id: 		service.id
							}

							meter_reading = MeterReading.new(meter_reading)
							meter_reading.save
							field_template[:meter_reading] = meter_reading.as_json(only: [:id, :reading, :tariff_id, :value_id, :created_at, :field_template_id])
						end
					end
				end
			end
			service.update_attributes(tariff_id: tariff.id)
		end
		service = Service.jsonify service
		service = Service.pack_data service, current_user, field_templates
		logger.info service.inspect
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
		service = Service.destroy_with_dependencies params[:service_id]
		render json: service
	end

end
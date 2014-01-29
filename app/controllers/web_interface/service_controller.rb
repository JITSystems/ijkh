# encoding: utf-8 

class WebInterface::ServiceController < WebInterfaceController
	
	def get_service
		@place = Place.find(params[:place_id])
		@services = @place.services.where("is_active IS NULL OR is_active != false")
		respond_to do |format|
			format.js {
				render 'web_interface/service/payment_services'
			}
		end
	end

	def delete
		@message = "Услуга успешно удалена"

		@service = Service.find(params[:service_id])
	
		if @service.update_attributes(is_active: false)
			respond_to do |format|
				format.js {render 'web_interface/service/delete'}
			end
		else
		#service delete error messeges here 
		end

	end


	def create
		@message = "Услуга успешно создана."


		unless params[:service][:vendor][:id] == '0'
			user_account = params[:service][:user_account]
			if (user_account.strip == '' || user_account == nil )
				@message = "Пожалуйста, введите лицевой счёт."
				respond_to do |format|
					format.js {
						render 'web_interface/service/error'
						}
				end
				return nil
			end
		end 

		if params[:service][:vendor][:id] == '20'
			delta_user_account = params[:service][:user_account]
			if (delta_user_account !~ /9\d{3}/ && delta_user_account !~ /79\d{2}/ && delta_user_account != '8602' && delta_user_account != '8888' || delta_user_account.length != 4)
				@message = "Неверный формат лицевого счёта."
				respond_to do |format|
					format.js {
						render 'web_interface/service/error'
						}
				end
				return nil
			end
		end 

		@place_id = params[:service][:place_id]
		@places = Place.where("user_id = ? and is_active = true", current_user.id).order("id DESC")
		@place = @places.find(@place_id)
		@service_types = ServiceTypeManager.index
    	@vendors = Vendor.select("id, title, service_type_id").where("is_active = true")
    	@tariff_templates = TariffTemplate.select("id, title, vendor_id, has_readings, service_type_id")
    	@field_templates = FieldTemplateManager.index
    	
		
		# Params fix
		fields_new = []
		temp = params[:service][:tariff][:fields]
		temp.first.each do |k,v|
			fields_new << v
		end

		params[:service][:tariff][:fields] = fields_new

		logger.info params.inspect
		@service = ServiceManager.create(params, current_user)

		respond_to do |format|
			format.js {
				render 'web_interface/service/create'
			}
		end

	end

			# def create
			# 	@message = "Услуга успешно создана."
			# 	vendor_title = Vendor.find(params[:service][:vendor_id]).title

			# 	service_params = {
			# 		user_id: 			current_user.id,
			# 		place_id: 			params[:service][:place_id],
			# 		service_type_id: 	params[:service][:service_type_id],
			# 		vendor_id: 			params[:service][:vendor_id],
			# 		user_account: 		params[:service][:user_account],
			# 		title: 				vendor_title
			# 	}

			# 	@service = Service.new(service_params)
				
			# 	if @service.save
			# 		@tariff_template = TariffTemplate.find(params[:service][:tariff_template_id])
			# 		tariff_params = {
			# 			title: 					@tariff_template.title,
			# 			tariff_template_id: 	params[:service][:tariff_template_id],
			# 			owner_id: 				params[:service][:vendor_id],
			# 			owner_type: 			"Vendor",
			# 			has_readings: 			@tariff_template.has_readings,
			# 			service_type_id: 		params[:service][:service_type_id],
			# 			service_id: 			@service.id
			# 		}

			# 		@tariff = Tariff.new(tariff_params)

			# 		account_params = {
			# 			user_id: 			current_user.id,
			# 			service_id: 		@service.id,
			# 			place_id:  			params[:service][:place_id],
			# 			status: 			1,
			# 			amount: 			"0"
			# 		}

			# 		@account = Account.new(account_params)

			# 		@account.save
					
			# 		if @tariff.save
			# 			@field_templates = @tariff_template.field_templates
			# 			@field_templates.each do |field_template|
			# 				field_params = {
			# 					title: 					field_template.title,
			# 					field_type: 			field_template.field_type,
			# 					is_for_calc: 			field_template.is_for_calc,
			# 					value: 					field_template.value,
			# 					reading_field_title: 	field_template.reading_field_title,
			# 					tariff_id: 				@tariff.id,
			# 					field_template_id: 		field_template.id,
			# 					field_units: 			field_template.field_units
			# 				}
			# 				@field = Field.new(field_params)
			# 				@field.save
			# 			end
			# 		end
			# 	end
				
			# 	respond_to do |format|
			# 		format.js {
			# 			render 'web_interface/service/create'
			# 		}
			# 	end
			# end
end

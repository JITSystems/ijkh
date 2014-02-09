# encoding: utf-8 

class WebInterface::ServiceController < WebInterfaceController
	
	def get_service
		# post 'get_service/:place_id' => 'web_interface/service#get_service'
      
		@place = Place.find(params[:place_id])
		@services = @place.services.where("is_active IS NULL OR is_active != false")
		respond_to do |format|
			format.js {
				render 'web_interface/service/payment_services'
			}
		end
	end

	def delete
      # put 'delete_service/:service_id' => 'web_interface/service#delete'

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
	# post 'service' => 'web_interface/service#create'
	
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
end
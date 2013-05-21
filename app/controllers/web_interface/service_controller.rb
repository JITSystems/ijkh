class WebInterface::ServiceController < WebInterfaceController
	def create

		vendor_title = Vendor.find(params[:service][:vendor_id]).title

		service_params = {
			place_id: 			params[:service][:place_id],
			service_type_id: 	params[:service][:service_type_id],
			vendor_id: 			params[:service][:vendor_id],
			user_account: 		params[:service][:user_account],
			title: 				vendor_title
		}
		service = Service.new(service_params)
		
		if service.save
			tariff_template = TariffTemplate.find(params[:service][:tariff_template_id])
			tariff_params = {
				title: 		tariff_template.title,
				tariff_template_id: 	params[:service][:tariff_template_id],
				owner_id: 				params[:service][:vendor_id],
				owner_type: 			"Vendor",
				has_readings: 			tariff_template.has_readings,
				service_type_id: 		params[:service][:service_type_id],
				service_id: 			service.id
			}

			tariff = Tariff.new(tariff_params)

			if tariff.save
				feild_templates = tariff_template.field_templates
			end
		else

		end
	end
end

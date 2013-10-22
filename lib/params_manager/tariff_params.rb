class TariffParams < ParamsManager

	def self.create(params, user, service)
		tariff_params(params[:service], user, service)
	end

private
	
	def self.tariff_params(params, user, service)
		tariff_template = TariffTemplateManager.get(params[:tariff][:id])

		t_p = {
			   tariff_template_id: 	params[:tariff][:id],
			   service_id: 		 	service.id,
			   service_type_id: 	params[:service_type_id],
			   has_readings: 		tariff_template.has_readings,
			   title: 				tariff_template.title
						}
		
		puts "*************"
		puts ( params["vendor"]["id"].to_i != 0 )

		unless params["vendor"]["id"].to_i != 0
			t_p.merge!(owner_type: "User", owner_id: user.id)
		else
			t_p.merge!(owner_type: "Vendor", owner_id: params["vendor"]["id"])
		end

		t_p
	end
end
# encoding: utf-8 

class ServiceParams < ParamsManager
	def self.create(params, user)
		service_params(params[:service], user)
	end

private
	
	def self.service_params(params, user)
		s_p = {
						  place_id: 		params[:place_id],
						  service_type_id: 	params[:service_type_id],
						  user_id: 			user.id,
						  is_active: 		true
						 }
		
		params[:vendor] ? s_p.merge!(vendor_id: params[:vendor][:id]) : s_p.merge!(vendor_id: 0)

		unless s_p[:vendor_id].to_s != "0" || params[:vendor_id]
			service_type = ServiceTypeManager.get(params[:service_type_id])
			s_p.merge!(title: service_type.title + " (Пользовательский)")
		else
			vendor = VendorManager.get(params[:vendor][:id])
			tariff = TariffTemplateManager.get(params[:tariff][:id])
			s_p.merge!(title: "#{vendor.title} - #{tariff.title}")
		end

		if params[:vendor][:id].to_i == 20
			if params[:user_account].to_s == "8602" || params[:user_account].to_s == "8888" || params[:user_account].to_s =~ /79\d{2}/ || params[:user_account].to_s =~ /9\d{3}/
			else
				s_p[:is_active] = false
			end
		end

		s_p.merge!(user_account: params[:user_account]) if params[:user_account]

		s_p
	end

end
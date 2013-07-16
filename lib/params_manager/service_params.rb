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
						  vendor_id: 		params[:vendor][:id],
						  user_id: 			user.id
						 }
		unless s_p[:vendor_id].to_s != "0" || params[:vendor_id]
			service_type = ServiceTypeManager.get(params[:service_type_id])
			s_p.merge!(title: service_type.title + " (Пользовательский)")
		else
			vendor = VendorManager.get(params[:vendor][:id])
			s_p.merge!(title: vendor.title)
		end
		s_p.merge!(user_account: params[:user_account]) if params[:user_account]

		s_p
	end

end
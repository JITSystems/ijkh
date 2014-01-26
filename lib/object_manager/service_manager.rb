class ServiceManager < ObjectManager
	
	def self.create(params, user)
		service = Service.new(ServiceParams.create(params, user))
		if service.save
			tariff = TariffManager.create(params, user, service)
			account = AccountManager.create(params, user, service)
			fields_and_meter_readings = FieldManager.create(params, service, tariff, user)
		else
			# Raise an exeption
		end
		return service
	end

	def self.index_by_place(place)
		place.services.where("is_active = true")
	end

	def self.deactivate(service_id)
		Service.find(service_id).update_attribute(:is_active, false)
	end

	def self.index_user_account(vendor_id)
		Service.where("vendor_id = ? and is_active = true", vendor_id).pluck(:user_account)
	end

	def update_user_service(params)
		fields_params = params[:service][:tariff][:fields]

		fields_params.each do |field_params|
			field = Field.find(field_params[:id])
			field.update_attributes(value: FloatModifier.substitute_comma(field_params[:value]).to_f)
		end
		return Service.find(params[:service_id])
	end
end
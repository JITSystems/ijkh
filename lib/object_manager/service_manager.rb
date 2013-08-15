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
		service
	end

	def self.index_by_place(place)
		place.services.where("is_active is null OR is_active != ?", false)
	end

	def self.deactivate(service_id)
		Service.find(service_id).update_attribute(:is_active, false)
	end
end
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
end
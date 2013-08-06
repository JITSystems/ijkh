class TariffManager < ObjectManager
	def self.create(params, user, service)
		tariff = Tariff.new(TariffParams.create(params, user, service))
		if tariff.save
			tariff
		else
			# Raise an exception
		end
	end
end
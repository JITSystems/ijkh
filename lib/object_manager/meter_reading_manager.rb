class MeterReadingManager < ObjectManager
	def self.create(params, service, field, user)
	end

	def self.get_by_tariff(tariff)
		tariff.meter_readings
	end
end
class FieldManager < ObjectManager
	
	def self.create(params, service, tariff, user)
		params[:service][:tariff][:fields].each do |p|
			puts p.inspect
			field = Field.create!(FieldParams.create(p, tariff))
			meter_reading = MeterReading.create!(MeterReadingParams.create(p, service, field, user)) if field.is_for_calc
		end
	end
	
end
class MeterReadingManager < ObjectManager	
  def self.create(user, params)
  	is_init = false
    meter_reading_params = {
    	service_id: params[:service_id],
    	reading: params[:meter_reading][:reading]
    	field_id: params[:meter_reading][:field_id]
    	user_id: user.id,
    	is_init: is_init
    }
  end

	def self.get_by_tariff(tariff)
		tariff.meter_readings
	end
end
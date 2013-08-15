# encoding: utf-8

class WebInterface::MeterReadingController < WebInterfaceController

	def create

		# params :
		# => service_id
		# => place_id
		# => prev_reading
		# => meter_reading :
		# 	=> field_id
		# 	=> reading
		# 	=> snapshot_url

		@message = "Показания счёчика обновлены"

		params[:meter_reading].each do |m_r| 

			service = Field.find(m_r[:field_id]).tariff.service
			service_id = service.id
			place_id = service.place.id

			meter_reading_params = {
				service_id: service_id,
				place_id: place_id,
				prev_reading: m_r[:prev_reading],
				meter_reading: {
					reading: m_r[:reading],
					field_id: m_r[:field_id]					
					}
			
			}

			if m_r[:reading].to_f < m_r[:prev_reading].to_f 
				@message = "Показания введены неверно"		
			else
				@meter_reading = MeterReading.new_meter_reading current_user, meter_reading_params
			end

			@account = Account.where(service_id: service_id).first


			@tariff = Tariff.where(service_id: service_id).first

			@fields = @tariff.fields

		end

		respond_to do |format|
			format.js {
				render 'web_interface/payment/save_meter_reading'
			}
		end

	end
end



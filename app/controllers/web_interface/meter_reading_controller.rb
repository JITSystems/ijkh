# encoding: utf-8

class WebInterface::MeterReadingController < WebInterfaceController

	def create
		
		@meter_reading = MeterReading.new_meter_reading current_user, params

		@message = "Показания сохранены"

		respond_to do |format|
			format.js {
				render 'web_interface/payment/save_meter_reading'
			}
		end

	end
end
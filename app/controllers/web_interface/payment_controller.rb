class WebInterface::PaymentController < WebInterfaceController
	def show
		@places = Place.where("user_id = ? and is_active = true", current_user.id).order("id DESC")
		@place = @places.first
		@services = @place.services.order("id DESC")
		@service = @services.first
		#@tariff = @service.tariff
	end

	def get_payment_data
		@tariff = Tariff.where(service_id: params[:service_id]).first
		@fields = @tariff.fields
		@account = Account.where(service_id: params[:service_id]).first

		respond_to do |format|
			format.js {
				render 'web_interface/payment/get_payment_data'
			}
		end
	end

	def get_meter_reading

		@fields = Field.where(tariff_id: params[:tariff_id])

		respond_to do |format|
			format.js {
				render 'web_interface/payment/get_meter_reading_data'
			}
		end
	end

	def get_recurrent_account
		@account = Account.new_recurrent_account params

		respond_to do |format|
			format.js {
				render 'web_interface/payment/get_recurrent_account_data'
			}
		end
	end
end
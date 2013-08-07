# encoding: utf-8

class WebInterface::PaymentController < WebInterfaceController
	def show
		@places = Place.where("user_id = ? and is_active = true", current_user.id).order("id DESC")
		if @places != []
			@place = @places.first
			@services = @place.services.order("id DESC").where("is_active != false")
			@service = @services.first
			#@tariff = @service.tariff
		end
	end

	def get_payment_data
		@tariff = Tariff.where(service_id: params[:service_id]).first

		if @tariff.has_readings
			@fields = @tariff.fields
			#@last_meter_reading = MeterReading.where(field_id: params[:field_id]).order("created_at DESC").limit(1).first
		else 
			@fields = @tariff.fields
		end

		@fields = @tariff.fields

		@account = Account.where(service_id: params[:service_id]).first

		respond_to do |format|
			format.js {
				render 'web_interface/payment/get_payment_data'
			}
		end
	end

	def pay
		@account = Account.find(params[:account_id])
		@vendor = @account.service.vendor

		recipe_params = {
			account_id: 	params[:account_id],
			service_id: 	@account.service.id,
			amount: 		params[:amount_total]
		}

		@recipe = Recipe.create_recipe current_user, recipe_params

		po_root_url = "https://secure.payonlinesystem.com/ru/payment/"

		user_id = current_user.id
		merchant_id = @vendor.merchant_id
		order_id = @recipe.id
		amount = FloatModifier.format(FloatModifier.modify(@recipe.total))
		currency = "RUB"
		private_security_key = @vendor.psk

		security_key_string ="MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&PrivateSecurityKey=#{private_security_key}"
		security_key = Digest::MD5.hexdigest(security_key_string)
		url = "#{po_root_url}?MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&SecurityKey=#{security_key}&user_id=#{user_id}&ReturnURL=https%3A//izkh.ru"
		respond_to do |format|
			format.js {
				render js: "window.location.replace('#{url}');"
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

		@message = "Счёт успешно создан"

		respond_to do |format|
			format.js {
				render 'web_interface/payment/get_recurrent_account_data'
			}
		end
	end

	def save_account_as_paid
		@message = "Счёт сохранён как оплаченный"

		@account = Account.hand_switch current_user, params

		respond_to do |format|
			format.js {
				render 'web_interface/payment/save_account_as_paid'
			}
		end
		
	end

end


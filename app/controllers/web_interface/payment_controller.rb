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

	def pay
		logger.info params.inspect
		@account= Account.find(params[:account_id])
		@vendor = @account.service.vendor

		recipe_params = {
			account_id: 	params[:account_id],
			service_id: 	@account.service.id,
			amount: 		params[:amount_total]
		}

		@recipe = Recipe.create_recipe current_user, recipe_params

		po_root_url = "https://secure.payonlinesystem.com/ru/payment/select"

		merchant_id = @vendor.merchant_id
		order_id = @recipe.id
		amount = @recipe.total
		currency = "RUB"
		private_security_key = "e45a8c7b-b0bd-4bdd-93d3-859b463daf81"

		security_key_string ="MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&PrivateSecurityKey=#{private_security_key}"
		logger.info security_key_string
		security_key = Digest::MD5.hexdigest(security_key_string)

		url = "#{po_root_url}?MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&SecurityKey=#{security_key}&returnUrl=http://izkh.ru"

		respond_to do |format|
			format.js {
				redirect_to url
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
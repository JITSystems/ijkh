# encoding: utf-8

class WebInterface::PaymentController < WebInterfaceController
	def show
		@places = Place.where("user_id = ? and is_active = true", current_user.id).order("id DESC")
		@cards = CardManager.get_by_user(current_user)
		if @places != []
			@place = @places.first
			@services = @place.services.order("id DESC").where("is_active IS NULL OR is_active != false")
			@service = @services.first
			#@tariff = @service.tariff
		end
	end

	def round_up amount
		amount = (amount*100).ceil/100.0
		return amount
	end

	def get_payment_data

		@tariff = Tariff.where(service_id: params[:service_id]).first
		@service = Service.find(params[:service_id])
		@service_id = params[:service_id]

		if @tariff.has_readings
			@fields = @tariff.fields
			#@last_meter_reading = MeterReading.where(field_id: params[:field_id]).order("created_at DESC").limit(1).first
		else 
			@fields = @tariff.fields
		end

		@fields = @tariff.fields
		@account = Account.where(service_id: params[:service_id]).first
		vendor_id = @account.service.vendor_id 

		unless vendor_id == 0
			@commission = VendorManager.get(vendor_id).commission
		else
			@commission = 0 
		end

		po_tax = 0
		service_tax = 0
		total = 0.0
		amount = @account.amount

		unless @commission 
			po_tax = 0
			service_tax = 0
			total = service_tax + amount
		else 
			service_tax = round_up((@commission.to_f/100.00)*amount).round(2)
			po_tax = 0
			total = service_tax + amount
		end

		@service_tax = service_tax
		@vendor_id = vendor_id


		if (vendor_id == 121)
			g_t_data = GlobalTelecom.new(@service.user_account)
			@g_t_data = g_t_data.check
		end

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
		merchant_id = '39859'
		user_id = current_user.id
		order_id = @recipe.id
		amount = FloatModifier.format(FloatModifier.modify(@recipe.total))
		currency = "RUB"
		private_security_key = '7ab9d14e-fb6b-4c78-88c2-002174a8cd88'

		if params[:rebill_anchor] != ''
			po_root_url = "https://secure.payonlinesystem.com/payment/transaction/rebill/"
			rebill_anchor = params[:rebill_anchor]
			security_key_string = "MerchantId=#{merchant_id}&RebillAnchor=#{rebill_anchor}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&PrivateSecurityKey=#{private_security_key}"
			security_key = Digest::MD5.hexdigest(security_key_string)
			url = "#{po_root_url}?MerchantId=#{merchant_id}&RebillAnchor=#{rebill_anchor}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&SecurityKey=#{security_key}&ContentType=xml&user_id=#{user_id}"
		else
		# 	po_root_url = "https://secure.payonlinesystem.com/payment/transaction/auth/"
		# 	ip = params[:payment][:ip]
		# 	card_number = params[:payment][:card_number]
		# 	cardholder_name = params[:payment][:cardholder_name]
		# 	email = params[:payment][:email]
		# 	card_exp_date = params[:payment][:card_exp_date]
		# 	card_cvv = params[:payment][:card_cvv]
			
		# 	security_key_string ="MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&PrivateSecurityKey=#{private_security_key}"
		# 	security_key = Digest::MD5.hexdigest(security_key_string)
			
		# 	payload = "MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&SecurityKey=#{security_key}&Ip=#{ip}&Email=#{email}&CardHolderName=#{cardholder_name}&CardNumber=#{card_number}&CardExpDate=#{card_exp_date}&CardCvv=#{card_cvv}&ContentType=xml&user_id=#{user_id}"
		# end	

		po_root_url = "https://secure.payonlinesystem.com/ru/payment/"

		# private_security_key = @vendor.psk
		# merchant_id = @vendor.merchant_id
	

		security_key_string ="MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&PrivateSecurityKey=#{private_security_key}"
		security_key = Digest::MD5.hexdigest(security_key_string)
		url = "#{po_root_url}?MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&SecurityKey=#{security_key}&user_id=#{user_id}&ReturnURL=https%3A//izkh.ru"
		end

		respond_to do |format|
			format.js {
				 render js: "window.location.replace('#{url}');"
				 # render js: "console.log('#{params}');"
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

		vendor_id = @account.service.vendor_id 

		unless vendor_id == 0
			@commission = VendorManager.get(vendor_id).commission
		else
			@commission = 0 
		end
			

		unless @commission
			@commission = 0
		end


		@message = "Счёт успешно создан"

		respond_to do |format|
			format.js {
				render 'web_interface/payment/get_recurrent_account_data'
			}
		end
	end

	def save_account_as_paid
		@message = "Счёт сохранён как оплаченный"

		params[:amount] = params[:amount_total] if params[:amount_total]

		@account = Account.hand_switch current_user, params		

		respond_to do |format|
			format.js {
				render 'web_interface/payment/save_account_as_paid'
			}
		end
		
	end

end


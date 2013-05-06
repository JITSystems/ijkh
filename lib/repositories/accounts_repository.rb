# encoding: utf-8 
module AccountsRepository

	def pay_bill user, params
		po_root_url = "https://secure.payonlinesystem.com/ru/payment/select"
		merchant_id = "39859"
		order_id = params[:bill_id]
		amount = params[:amount]
		currency = "RUB"
		private_security_key = "7ab9d14e-fb6b-4c78-88c2-002174a8cd88"

		security_key_string ="MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&PrivateSecurityKey=#{private_security_key}"

		security_key = Digest::MD5.hexdigest(security_key_string)

		url = "#{po_root_url}?MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&SecurityKey=#{security_key}&returnUrl=http://izkh.ru"
	end

	def index_place_account user, status
		place_accounts = PlaceAccount.get_by_user_id user.id, status
	end

	def update_account_amount service_id, amount_subtrahend, amount
		account = fetch_account_by_service service_id
		amount = account.amount.to_f - amount_subtrahend.to_f
		amount = amount.round(2)
		if amount < 0.0
			amount = 0.0
		end

		account.update_attributes(amount: amount)
		return {amount: amount, account_id: account.id}
	end


	def new_account params
		account = fetch_account_by_service params[:service_id]

		if account
			amount_params = {
				field_id: params[:field_id],
				reading: params[:reading],
				prev_reading: params[:prev_reading]
			}
			update_amount account, amount_params
		end

		account
	end

	def new_recurrent_account params
		account = fetch_account_by_service params[:service_id]
		
		service = Service.find(params[:service_id])
		
		field = service.tariff.fields.first

		if account
			amount_params = {
				field_id: field.id,
				reading: 2,
				prev_reading: 1
			}
			update_amount account, amount_params
		end
	end
	
	def hand_switch params
		account = self.find(params[:account_id])

		if account.update_attributes(status: 1, amount: "0.00")
			currency = "RUB"
			amount = account.amount

			recipe_params = {
				amount: 				amount, 
				currency: 				currency, 
				user_id: 				params[:user_id],
				service_id: 			account.service_id,
				account_id: 			account.id
			}

			recipe = Recipe.new(recipe_params)
			recipe.save

			payment_history_params = {
				amount: 				amount, 
				currency: 				currency, 
				user_id: 				params[:user_id],
				payment_type: 			"0",
				status: 				1,
				service_id: 			account.service_id,
				recipe_id: 				recipe.id
			}
			
			payment_history = PaymentHistory.new(payment_history_params)
			payment_history.save
		end
	end

	def switch_status params
		account = self.find(params[:account_id])
		if account.update_attributes(status: params[:status])
			{status: "updated"}
		else
			{error: "something went wrong"}
		end
	end

private

	def calculate_amount value, reading, prev_reading
		reading_delta = reading.to_f - prev_reading.to_f
		amount = reading_delta*value.to_f
		format_amount amount.round(2)
	end

	def format_amount amount
		amount = amount.to_s.split(".")
		if amount.last =~ /\d\d/
			amount_str = amount.first + "." + amount.last 
		else
			amount_str = amount.first + "." + amount.last + "0"
		end
		amount_str
	end

	def update_amount account, amount_params
		value = Field.get_value amount_params[:field_id]
		reading = amount_params[:reading]
		prev_reading = amount_params[:prev_reading]

		amount = calculate_amount value, reading, prev_reading
		account.update_attributes(amount: amount, status: '-1')
		account
	end

	def fetch_account_by_service service_id
		account = self.where(service_id: service_id).first
	end
end
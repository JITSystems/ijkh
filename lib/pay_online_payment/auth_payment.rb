class AuthPayment < PayOnlinePayment
	def initialize(service_id, amount, order_id, user_id, merchant_id, ip, card_number, cardholder_name, email, card_exp_date, card_cvv, auth_token)
		@service_id = service_id
		@amount = amount
		@order_id = order_id
		@user_id = user_id
		@merchant_id = merchant_id
		@ip = ip
		@card_number = card_number
		@cardholder_name = cardholder_name
		@email = email
		@card_exp_date = card_exp_date
		@card_cvv = card_cvv
		@auth_token = auth_token
		@po_root_url = "https://secure.payonlinesystem.com/payment/transaction/auth/"
	end

	def pay
		PayOnlineWorker.perform_async(@po_root_url, url_params, @auth_token)
	end

protected

	def url_params
		security_key_string = "MerchantId=#{@merchant_id}&OrderId=#{@order_id}&Amount=#{@amount}&Currency=RUB&PrivateSecurityKey=#{get_private_key(@service_id)}"
		"MerchantId=#{@merchant_id}&OrderId=#{@order_id}&Amount=#{@amount}&Currency=RUB&SecurityKey=#{get_public_key(security_key_string)}&Ip=#{@ip}&Email=#{@email}&CardHolderName=#{@cardholder_name}&CardNumber=#{@card_number}&CardExpDate=#{@card_exp_date}&CardCvv=#{@card_cvv}&ContentType=xml&user_id=#{@user_id}"
	end

end
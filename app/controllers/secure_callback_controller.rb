class SecureCallbackController < ApplicationController
	skip_before_filter :require_auth_token
	def secure_callback
		md = params["MD"]
		pares = params["PaRes"]
		id, pd, account_id = md.split(';')

		vendor = Account.find(account_id).service.vendor
		merchant_id = vendor.merchant_id
		psk = vendor.psk
		user_id = Account.find(account_id).user_id
		auth_token = User.find(user_id).authentication_token

		security_key_string = "MerchantId=#{merchant_id}&TransactionId=#{id}&PARes=#{pares}&PD=#{pd}&PrivateSecurityKey=#{psk}"
		security_key = Digest::MD5.hexdigest(security_key_string)
		payload = "MerchantId=#{merchant_id}TransactionId=#{id}&PARes=#{pares}&PD=#{pd}&SecurityKey=#{security_key}&ContentType=xml&user_id=#{user_id}"
		po_root_url = "https://secure.payonlinesystem.com/payment/transaction/auth/3ds/"
		TdsAuthWorker.perform_async(po_root_url, payload, auth_token)

		render json: {}
	end
end
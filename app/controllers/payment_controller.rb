# encoding: utf-8
class PaymentController < ApplicationController

	def subscribe
  		render json: {base_url: "http://izkh.ru:9292/faye", channel_title: "/server/#{params[:auth_token]}"}
	end

	def pay
		po_root_url = ""
		service_id = params[:payment][:service_id]
		amount = params[:payment][:amount]
		order_id = params[:payment][:recipe_id]
		user_id = current_user.id
		merchant_id = params[:payment][:merchant_id]
		
		@vendor = Service.find(service_id).vendor
		currency = "RUB"
		private_security_key = @vendor.psk
		
		security_key_string = ""
		payload = ""

		if params[:payment][:rebill_anchor]
			po_root_url = "https://secure.payonlinesystem.com/payment/transaction/rebill/"
			rebill_anchor = params[:payment][:rebill_anchor]
			security_key_string = "MerchantId=#{merchant_id}&RebillAnchor=#{rebill_anchor}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&PrivateSecurityKey=#{private_security_key}"
			security_key = Digest::MD5.hexdigest(security_key_string)
			payload = "MerchantId=#{merchant_id}&RebillAnchor=#{rebill_anchor}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&SecurityKey=#{security_key}&ContentType=xml&user_id=#{user_id}"
		else
			po_root_url = "https://secure.payonlinesystem.com/payment/transaction/auth/"
			ip = params[:payment][:ip]
			card_number = params[:payment][:card_number]
			cardholder_name = params[:payment][:cardholder_name]
			email = params[:payment][:email]
			card_exp_date = params[:payment][:card_exp_date]
			card_cvv = params[:payment][:card_cvv]
			
			security_key_string ="MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&PrivateSecurityKey=#{private_security_key}"
			security_key = Digest::MD5.hexdigest(security_key_string)
			
			payload = "MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&SecurityKey=#{security_key}&Ip=#{ip}&Email=#{email}&CardHolderName=#{cardholder_name}&CardNumber=#{card_number}&CardExpDate=#{card_exp_date}&CardCvv=#{card_cvv}&ContentType=xml&user_id=#{user_id}"
		end	
		HttpRequestWorker.perform_async(po_root_url, payload, params[:auth_token])
  		render json: {}
	end
end
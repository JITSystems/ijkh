# encoding: utf-8
class PaymentController < ApplicationController

	def subscribe
  		render json: {base_url: "https://izkh.ru:9292/faye", channel_title: "/server/#{params[:auth_token]}"}
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

	def secure_callback
		logger.info params.inspect
	end

	def test
		po_root_url = "https://secure.payonlinesystem.com/payment/transaction/auth/"
		security_key = Digest::MD5.hexdigest('MerchantId=43222&OrderId=844&Amount=1.03&Currency=RUB&PrivateSecurityKey=e45a8c7b-b0bd-4bdd-93d3-859b463daf81')
		data = "MerchantId=43222&OrderId=844&Amount=1.03&Currency=RUB&SecurityKey=#{security_key}&Ip=192.168.1.4&Email=alonnight@gmail.com&CardHolderName=SVYATOSLAV RADAEV&CardNumber=4779646367398246&CardExpDate=0815&CardCvv=856&ContentType=xml&user_id=1"
		require 'net/http'
		require 'net/https'
		uri = URI.parse(po_root_url)
		https = Net::HTTP.new(uri.host, uri.port)
		https.use_ssl = true
		post = Net::HTTP::Post.new(uri.path)
		post.body = data
		response = https.request(post)
		response = Crack::XML.parse(response.body.to_s)
		@pareq = response['transaction']['threedSecure']['pareq']
		@acsurl = response['transaction']['threedSecure']['acsurl']
		@md = "#{response['transaction']['id']};#{response['transaction']['threedSecure']['pd']}"

		render 'payment/test'
	end
end
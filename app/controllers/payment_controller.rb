# encoding: utf-8
class PaymentController < ApplicationController
		skip_before_filter :require_auth_token, only: :tds_callback
	def subscribe
  		render json: {base_url: "http://izkh.ru:9292/faye", channel_title: "/server/#{params[:auth_token]}"}
	end

	def pay
		service_id = params[:payment][:service_id]
		amount = params[:payment][:amount]
		order_id = params[:payment][:recipe_id]
		user_id = current_user.id
		merchant_id = params[:payment][:merchant_id]
		auth_token = params[:auth_token]
		
		if params[:payment][:rebill_anchor]
			rebill_anchor = params[:payment][:rebill_anchor]
			rebill_payment = RebillPayment.new(service_id, amount, order_id, user_id, merchant_id, rebill_anchor, auth_token)
			rebill_payment.pay
		else
			ip = params[:payment][:ip]
			card_number = params[:payment][:card_number]
			cardholder_name = params[:payment][:cardholder_name]
			email = params[:payment][:email]
			card_exp_date = params[:payment][:card_exp_date]
			card_cvv = params[:payment][:card_cvv]	
			auth_payment = AuthPayment.new(service_id, amount, order_id, user_id, merchant_id, ip, card_number, cardholder_name, email, card_exp_date, card_cvv, auth_token)
			auth_payment.pay
		end	
  		
  		render json: {}
	end

	def tds_callback
		md = params["MD"]
		pares = params["PaRes"]
		
		tds_payment = TdsPayment.new(pares, md)
		tds_payment.pay

		render json: {}
	end
end
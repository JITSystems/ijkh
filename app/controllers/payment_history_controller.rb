# encoding: utf-8
class PaymentHistoryController < ApplicationController
	skip_before_filter :require_auth_token
	
	def index
		
	end

	def index_by_month
		@month = params[:payment_history][:month]
		@payment_histories = PaymentHistory.where("extract(month from created_at) = ?", @month)
		render json: {payment_history: @payment_histories}
	end

	def success
		payment_history = PaymentHistory.create_payment_history params
		analytic = Analytic.create_analytic params

		@user = User.find(params[:user_id].to_i)
		@recipe = Recipe.find(params[:OrderId].to_i)
		@vendor = Service.find(@recipe.service_id).vendor

		@message = PaymentMessage.new(subject: "Новый платеж", name: @user.first_name, email: @user.email, vendor: @vendor.title, amount: params[:Amount], date: params[:DateTime])
		PaymentMailer.new_message(@message).deliver
		render json: {}
	end

	def fail
		payment_history = PaymentHistory.create_payment_history params

		render json: {}
	end

	def index_by_vendor
	end
end
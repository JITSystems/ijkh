# encoding: utf-8
class PaymentHistoryController < ApplicationController
	skip_before_filter :require_auth_token

	def index_by_month
		@month = params[:payment_history][:month]
		@payment_histories = PaymentHistory.where("extract(month from created_at) = ?", @month)
		render json: {payment_history: @payment_histories}
	end

	def success
	# Creates successful payment history, analytic entry, updates account status/amount, 
	# card if rebill_anchor, invokes payment workers
		
		payment_history = PaymentHistory.create_payment_history params # rewrite to manager
		analytic = Analytic.create_analytic params	# rewrite to manager
		# decrease account amount and update status here
		# add card if rebill anchor
		# invoke payment workers
		
		#@user = User.find(params[:user_id].to_i)
		#@recipe = Recipe.find(params[:OrderId].to_i)
		#@vendor = Service.find(@recipe.service_id).vendor

		#PaymentNotificationWorker.perform_async(@user.first_name, @user.email, @vendor.title, params[:Amount], params[:DateTime])
		
		render json: {}
	end

	def fail
	# Creates failed payment history
		
		payment_history = PaymentHistory.create_payment_history params

		render json: {}
	end

	def terminal 
		payment_history = TerminalPayment.new(params[:payment_data])
		if payment_history.save
			render json: {status: "success"}, status: 200
		else
			render json: {staus: "fail"}, status: 500
		end
	end
end
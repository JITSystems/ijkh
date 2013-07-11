class PaymentHistoryController < ApplicationController
	skip_before_filter :require_auth_token
	
	def index
		
	end

	def index_by_month
		@month = params[:payment_history][:month]
		@payment_histories = PaymentHistory.where("extract(month from created_at) = ?", @month)
		p @payment_histories
		render json: {payment_history: @payment_histories}
	end

	def success
		payment_history = PaymentHistory.create_payment_history params
		analytic = Analytic.create_analytic params
		render json: {}
	end

	def fail
		payment_history = PaymentHistory.create_payment_history params

		render json: {}
	end

	def index_by_vendor
	end
end
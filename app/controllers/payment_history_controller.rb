class PaymentHistoryController < ApplicationController
	skip_before_filter :require_auth_token
	
	def index
		
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
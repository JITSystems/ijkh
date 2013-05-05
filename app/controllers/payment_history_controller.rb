class PaymentHistoryController < ApplicationController
	def index
		
	end

	def success
		payment_history = PaymentHistory.create_payment_history params
		
		render json: {}
	end

	def fail
		payment_history = PaymentHistory.create_payment_history params

		render json: {}
	end
end
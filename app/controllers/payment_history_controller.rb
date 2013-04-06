class PaymentHistoryController < ApplicationController
	def index
		payment_histories = PaymentHistory.by_user(current_user)
		render json: payment_histories
	end

	def success
		logger.info params.inspect
	end

	def fail
		logger.info params.inspect
	end
end
class PaymentHistoryController < ApplicationController
	def index
		payment_histories = PaymentHistory.by_user(current_user)
		render json: payment_histories
	end

	def create
		
	end

	def update
	end

	def destroy
		payment_history = PaymentHistory.find(params[:payment_history_id])
		if payment_history.destroy
			render json: {status: "deleted"}
		end
	end
end
class PaymentHistoryController < ApplicationController
	def index
		#bill_ids = Bill.where("place_id = ? and service_type_id = ? and user_id = ?", params[:place_id], params[:service_type_id], current_user.id).map(&:id)
		#payment_histories = PaymentHistory.where("")
		#render json: payment_histories
	end

	def success
		payment_history = PaymentHistory.create_payment_history current_user, params
		
		render json: {}
	end

	def fail
		payment_history = PaymentHistory.create_payment_history current_user, params

		render json: {}
	end
end
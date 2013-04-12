class PaymentHistoryController < ApplicationController
	def index
		#bill_ids = Bill.where("place_id = ? and service_type_id = ? and user_id = ?", params[:place_id], params[:service_type_id], current_user.id).map(&:id)
		#payment_histories = PaymentHistory.where("")
		#render json: payment_histories
	end

	def success
		logger.info params.inspect
		payment_history = PaymentHistory.new(po_date_time: params[:DateTime], po_transaction_id: params[:TransactionID], bill_id: params[:OrderId], amount: params[:Amount], currency: params[:Currency], card_holder: params[:CardHolder], card_number: params[:CardNumber], country: params[:Country], city: params[:City], eci: params[:ECI])
		bill.switch_status { bill_id params[:OrderId], status: "1"}
		render json: {}
	end

	def fail
		logger.info params.inspect
		payment_history = PaymentHistory.new(po_date_time: params[:DateTime], po_transaction_id: params[:TransactionID], bill_id: params[:OrderId], amount: params[:Amount], currency: params[:Currency], card_holder: params[:CardHolder], card_number: params[:CardNumber], country: params[:Country], city: params[:City], eci: params[:ECI])
		bill.switch_status { bill_id params[:OrderId], status: "-1"}
		render json: {}
	end
end
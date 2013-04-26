class PaymentHistoryController < ApplicationController
	def index
		#bill_ids = Bill.where("place_id = ? and service_type_id = ? and user_id = ?", params[:place_id], params[:service_type_id], current_user.id).map(&:id)
		#payment_histories = PaymentHistory.where("")
		#render json: payment_histories
	end

	def success
		payment_history = PaymentHistory.new(po_date_time: params[:DateTime], po_transaction_id: params[:TransactionID], account_id: params[:OrderId], amount: params[:Amount], currency: params[:Currency], card_holder: params[:CardHolder], card_number: params[:CardNumber], country: params[:Country], city: params[:City], eci: params[:ECI])
		account_params = {account_id: params[:OrderId], status: "1"}
		Account.switch_status account_params
		render json: {}
	end

	def fail
		payment_history = PaymentHistory.new(po_date_time: params[:DateTime], po_transaction_id: params[:TransactionID], account_id: params[:OrderId], amount: params[:Amount], currency: params[:Currency], card_holder: params[:CardHolder], card_number: params[:CardNumber], country: params[:Country], city: params[:City], eci: params[:ECI])
		account_params = {account_id: params[:OrderId], status: "-1"}
		Account.switch_status account_params
		render json: {}
	end
end
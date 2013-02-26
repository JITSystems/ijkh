class PaymentHistoryController < ApplicationController
	def index
		@user = User.select(:id).where(authentication_auth: params[:auth_token]).first
		@payment_histories = PaymentHistory.select("id, card_id, amuont").where(user_id: @user.id)

		render json: @payment_histories
	end

	def create
		
	end

	def update
		
	end

	def destroy
		@payment_history = PaymentHistory.find(params[:payment_history_id])
		if @payment_history.destroy
			render json: {status: "deleted"}
		end
	end
end
class BillController < ApplicationController
	def index
		@user = User.select(:id).where(authentication_auth: params[:auth_token]).first
		@bills = Bill.where(user_id: @user.id)

		render json: @bills
	end

	def create
		#TO-DO: When does the bill instance is to be created?
	end

	def update
		@bill = Bill.find(params[:bill_id])
		if @bill.update_attributes(params[:bill])
			render json: {bill: @bill.as_json(only: [:id, :amount, :is_paid, :service_id])}
		else
			render json: {status: "something went wrong"}
		end
	end

	def destroy
		@bill = Bill.find(params[:bill_id])
		if @bill.destroy
			render json: {status: "deleted"}
		end
	end
end
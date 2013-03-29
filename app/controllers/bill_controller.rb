class BillController < ApplicationController
	def index
		#bills = Bill.load_last_3_months(current_month, current_user)
		billys = Bill.index_month_bill current_user, 1
		render json: billys
	end

	def destroy
		bill = Bill.find(params[:bill_id])
		if bill.destroy
			render json: {status: "deleted"}
		end
	end
end
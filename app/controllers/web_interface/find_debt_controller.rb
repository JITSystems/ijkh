# encoding: utf-8 

class WebInterface::FindDebtController < WebInterfaceController
	include HTTParty

	def show

	end

	def get_user_account_info

		debt = DebtManager.new(params[:vendor_id], params[:user_account], current_user.id, request.remote_ip)
		
		@info = debt.check_debt 

		render json: @info

	end
end
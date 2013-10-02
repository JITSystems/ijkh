# encoding: utf-8 

class WebInterface::EnergosbytController < WebInterfaceController
	include HTTParty

	def show

	end

	def get_user_account_info

		@info = HTTParty.get('http://cabinet.izkh.ru/energosbyt', :query => { :user_account => params[:user_account]} )

		data = {
			user_account: params[:user_account],
			user_id: current_user.id,
			remote_ip: request.remote_ip,
		}

		EnergosbytWorker.perform_async('http://cabinet.izkh.ru/energosbyt', data)

		render json: @info

	end
end
# encoding: utf-8 

class WebInterface::EnergosbytController < WebInterfaceController
	include HTTParty

	base_uri "http://cabinet.izkh.ru"

	def show

	end

	def get_user_account_info

		options = params[:user_account]

		@info = HTTParty.get('http://cabinet.izkh.ru/energosbyt', :query => {:user_account => options} )

		render json: @info
		# respond_to do |format|
		# 	format.js {
		# 		render 'web_interface/energosbyt/get_user_account_info'
		# 	}
		# end

	end


end
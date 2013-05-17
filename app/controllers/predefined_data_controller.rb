class PredefinedDataController < ApplicationController
	def index
		if current_user
			render json: {
						user: {
							auth_token: current_user.authentication_token, 
                       		email: current_user.email,
                       		first_name: current_user.first_name,
                       		phone_number: current_user.phone_number
                      			} 
                    	}
		else
			render json: {error: "Auth failed"} #dummy
		end
	end
end

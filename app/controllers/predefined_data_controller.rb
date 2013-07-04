class PredefinedDataController < ApplicationController
	skip_before_filter :require_auth_token
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

	def apns
	  APNS.host = Settings.apns.host
      APNS.pem  = 'apns.pem'
      APNS.port = Settings.apns.port.to_i
	  device_token = 'ed582741 0ba963a1 72666ec2 2dc94ae1 69e1d184 deff5b9b f45214a2 d877833d'
      APNS.send_notification(device_token, :alert => 'Privet, drug!', :sound => 'default')
      render json: "success"
	end
end

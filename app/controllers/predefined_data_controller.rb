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

  def register_ios_device
    current_user.register_ios_device(params[:device_token])
  end
 

	def apns
	  APNS.host = Settings.apns.host
      APNS.pem  = Settings.apns.pem_file
      APNS.port = Settings.apns.port.to_i
	  device_token = current_user.ios_device_token

	  if device_token
      	APNS.send_notification(device_token, :alert => params[:text], :sound => 'default')
      	render json: "success"
      else
      	render json: "failure"
      end
	end
end

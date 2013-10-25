# encoding: utf-8 
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
    render json: {}
  end
 

	def apns
    PushNotificationsWorker.perform_async
    render json: {status: "success"}
	end

  def new_vendors_notification
    VendorPushNotificationsWorker.perform_async
    render json: {status: "success"}
  end

  def osmp
    resp = Osmp.check
    render json: resp.body
  end
end

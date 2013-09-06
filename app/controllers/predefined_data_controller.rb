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
    APNS.host = Settings.apns.host
    APNS.pem  = Settings.apns.pem_file
    APNS.port = Settings.apns.port.to_i
    text = "В связи с техническими работами временно недоступна оплата через мобильное приложение 'АйЖКХ'. Оплату услуг Вы можете осуществить на сайте сервиса izkh.ru. Приносим извинения за неудобства."
    #users = User.all
    #users.each do |user|
    user = User.find(2)
    if user.ios_device_token
      APNS.send_notification(user.ios_device_token, :alert => text, :sound => 'default')
    end
    render json: {status: "success"}
	end
end

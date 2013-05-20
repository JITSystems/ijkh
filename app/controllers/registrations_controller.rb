# encoding: utf-8 

class RegistrationsController < Devise::RegistrationsController

  skip_before_filter :require_auth_token

  def new
    @service_types = ServiceType.select("id, title").all
    @vendors = Vendor.select("id, title, service_type_id").all
    @tariff_templates = TariffTemplate.select("id, title, vendor_id").where("vendor_id != 0")
    
  end

	def create
    logger.info "Createeeeee!!!"
    	user = User.new(params[:user])
    	if user.save

      respond_to do |format|
        format.json {
      		render json: {user: 
                      {auth_token: user.authentication_token, 
      								email: user.email, 
      								first_name: user.first_name, 
      								phone_number: user.phone_number}}, status: 201
      		return
        }
        format.html {
          sign_in("user", user)
          redirect_to '/main'
          return
        }
        format.js {
          sign_in("user", user)
          render 'web_interface/registration/create'
        }
      end
    	else
      		warden.custom_failure!
          respond_to do |format|
            format.json {
          user_errors = ""
          user.errors.each do |error|
            if error.to_s == "emails"
              user_errors = "Данный адрес эл. почты уже зарегистрирован."
            else
              user_errors = "Неверно введены данные регистрации."
            end
          end

      		render json:  {error: {message: user_errors}}, status: 422
          return
        }
        format.html {
          redirect_to '/registration'
          return
        }
        format.js {

        }
    	end
    end
	end	
end

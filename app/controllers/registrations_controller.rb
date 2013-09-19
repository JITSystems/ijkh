# encoding: utf-8 

class RegistrationsController < Devise::RegistrationsController

  skip_before_filter :require_auth_token

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      respond_to do |f|
        @first_name = params[:user][:first_name]
        @email = params[:user][:email]
        @phone_number = params[:user][:phone_number]
        @message = 'Данные успешно изменены'
        f.js { render 'devise/registrations/update' }
    end
    else
      respond_to do |f|
        f.js { render 'devise/registrations/error'}
      end
    end
  end

  def new
    @service_types = ServiceType.select("id, title").all
    @vendors = Vendor.select("id, title, service_type_id").all
    @tariff_templates = TariffTemplate.select("id, title, vendor_id, has_readings").where("vendor_id != 0")
  end

	def create
    @message = "Вы зарегистрировались!"
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
        
        # format.html {
        #   redirect_to '/registration'
        #   return
        # }

          @message = ""
          unless user.errors.first.first.to_s == "email"
            @message = "Пароль должен содержать не менее 6 символов"  
          else
            @message = "Данный адрес эл. почты уже зарегистрирован."
          end

          # user.errors.each do |error|
          # @message << user.errors.first.first.to_s
          # end

          format.js {
            render 'web_interface/registration/error'
          }
    	end
    end
	end	
end

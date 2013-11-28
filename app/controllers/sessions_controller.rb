# encoding: utf-8 
class SessionsController < Devise::SessionsController

  skip_before_filter :require_auth_token

	prepend_before_filter :require_no_authentication, :only => [:create]
  before_filter :ensure_params_exist, :except => [:destroy, :new]

  def new
    
  end
 
  def create
    build_resource
    resource = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_login_attempt unless resource
 
    if resource.valid_password?(params[:user][:password])
      sign_in("user", resource)

      JtIntegrationWorker.perform_async(current_user.id)
      GtIntegrationWorker.perform_async(current_user.id)

      respond_to do |format|

        format.json {
          render json: {user: 
                        {
                          auth_token: resource.authentication_token, 
                          email: resource.email,
                          first_name: resource.first_name,
                          phone_number: resource.phone_number
                        } 
                      }
                    }
        format.html {
          redirect_to "/main"
        }
      end

      return
    end
    invalid_login_attempt
  end
  
  def destroy
    super
  end
 
  protected
  def ensure_params_exist
    return unless params[:user][:email].blank?
    render json: { error: {message: "Отсутствует email"}}, status: 422
  end
 
  def invalid_login_attempt
    warden.custom_failure!
    respond_to do |format|
      format.json {
    render json: { error: {message: "Неверный адрес эл. почты или пароль."}}, status: 401
  }
    format.html { redirect_to "/login" }
  end
  end
end

class SessionsController < Devise::SessionsController
	prepend_before_filter :require_no_authentication, :only => [:create]
  before_filter :ensure_params_exist, :except => [:destroy]
  
  def create
    build_resource
    resource = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_login_attempt unless resource
 
    if resource.valid_password?(params[:user][:password])
      sign_in("user", resource)
      render json: {user: 
                      {auth_token: resource.authentication_token, 
                       email: resource.email,
                       first_name: resource.first_name,
                       phone_number: resource.phone_number
                      } 
                    }
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
    render :json=>{:success=>false, :message=>"missing email parameter"}, :status=>422
  end
 
  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end
end

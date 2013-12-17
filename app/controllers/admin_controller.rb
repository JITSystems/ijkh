class AdminController < ApplicationController

 # before_filter :authenticate_user!
  skip_before_filter :require_auth_token
  before_filter :require_current_user

  def require_current_user
	unless current_user && current_user.id == 2 || current_user.id == 6
		redirect_to "/login"
	end
  end
  
  layout 'admin'

end
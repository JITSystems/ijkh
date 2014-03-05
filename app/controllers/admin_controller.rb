class AdminController < ApplicationController

  skip_before_filter :require_auth_token
  before_filter :require_current_user

  def require_current_user
	if current_user
		p current_user
		if current_user.admin
		else
			redirect_to "/login"
		end
	else
		redirect_to "/login"
	end
  end
  
  layout 'admin'

end
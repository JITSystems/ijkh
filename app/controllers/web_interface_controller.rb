class WebInterfaceController < ApplicationController
	skip_before_filter :require_auth_token
	
	def require_current_user
		unless current_user
			redirect_to "/login"
		end
	end
end
class WebInterfaceController < ApplicationController
	skip_before_filter :require_auth_token
	before_filter :require_current_user
	before_filter :get_site_dynamic_data

	def require_current_user
		unless current_user
			redirect_to "/login"
		end
	end

	def get_site_dynamic_data
		@sdd = SiteDynamicData.first
	end
end
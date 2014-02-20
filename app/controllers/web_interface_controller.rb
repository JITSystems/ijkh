class WebInterfaceController < ApplicationController
	skip_before_filter :require_auth_token

	before_filter :require_current_user
	before_filter :get_freelancers

	def require_current_user
		unless current_user
			redirect_to "/login"
		end
	end

	def get_freelancers
		@freelancers = FreelanceInterface::Freelancer.find([13, 14])
	end
end
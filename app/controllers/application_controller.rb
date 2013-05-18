class ApplicationController < ActionController::Base
	before_filter :require_auth_token

	private

	def require_auth_token

		if !params[:auth_token] || params[:auth_token] = ""
			render json: {error: {message: "No auth token"}}, status: 401
		end

	end
end

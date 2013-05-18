class ApplicationController < ActionController::Base
	before_filter :require_auth_token

	private

	def require_auth_token

		unless params[:auth_token]
			render json: {error: "No auth token"}, status: 401
		end

		if params[:auth_token] = ""
			render json: {error: "No auth token"}, status: 401
		end
	end
end

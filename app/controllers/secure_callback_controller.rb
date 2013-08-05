class SecureCallbackController < ApplicationController
	skip_before_filter :require_auth_token
	def secure_callback
		logger.info params.inspect
		render json: {}
	end
end
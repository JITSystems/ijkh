class ServiceAccountController < ApplicationController
	def show
		@service_account = ServiceAccount.get_by_service params[:service_id]
	end
end
class ServiceAccountController < ApplicationController
	def show
		# GET api/1.0/service/:service_id/serviceaccount
		@service_account = ServiceAccount.get_by_service params[:service_id]
	end
end
class NonUtilityVendorController < ApplicationController
	skip_before_filter :require_auth_token

	def index_by_service_type
		# GET api/1.0/nonutilityservicetype/:non_utility_service_type_id/nonutilityvendor
		@non_utility_vendors = NonUtilityVendorManager.index_by_service_type(params[:non_utility_service_type_id])
		render json: @non_utility_vendors
	end

	def create
		# POST api/1.0/non_utility_vendor
		NonUtilityVendorManager.create(params)
		render json: {}
	end
end
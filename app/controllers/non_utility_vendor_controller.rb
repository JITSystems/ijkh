class NonUtilityVendorController < ApplicationController
	skip_before_filter :require_auth_token
	def index_by_service_type
		@non_utility_vendors = NonUtilityVendor.where(non_utility_service_type_id: params[:non_utility_service_type_id])
		render json: @non_utility_vendors
	end

	def create
		@non_utility_vendor = NonUtilityVendorManager.create(params[:non_utility_vendor])
		render json: @non_utility_vendor.as_json
	end
end
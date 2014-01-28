class VendorController < ApplicationController
	
	skip_before_filter :require_auth_token

	def index_with_tariffs
		# GET api/1.0/servicetype/:service_type_id/vendors
		@vendors = VendorManager.index_with_tariffs(ServiceTypeManager.get(params[:service_type_id]))
		render 'vendor/index_with_tariffs'
	end

	def create
		# POST api/1.0/vendor
		@vendor = VendorManager.create(params)
		render 'vendor/show'
	end

	def index
		# GET api/1.0/vendors
		@vendors = VendorManager.index
		render 'vendor/index'
	end

	def show_by_inn
		# GET api/1.0/vendor/show_by_inn
		@vendors = VendorManager.fetch_by_inn(params[:inn])
		render 'vendor/index_with_tariffs'
	end
end
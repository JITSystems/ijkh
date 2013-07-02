class VendorController < ApplicationController
	
	skip_before_filter :require_auth_token

	def index_with_tariffs
		@vendors = VendorManager.index_with_tariffs(ServiceTypeManager.get(params[:service_type_id]))
		render 'vendor/index_with_tariffs'
	end

	def create
		@vendor = VendorManager.create(params[:vendor])
		render 'vendor/show'
	end

	def index
		@vendors = VendorManager.index
		render 'vendor/index'
	end
end
class VendorController < ApplicationController
	def index_with_tariffs
		@vendors = Vendor.where(service_type_id: params[:service_type_id])
		render 'vendor/index'
	end

	def create
		@vendor = Vendor.new params[:vendor]
	end
end
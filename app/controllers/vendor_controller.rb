class VendorController < ApplicationController
	def index_with_tariffs
		@vendors = Vendor.where("service_type_id = ? and is_active = true",params[:service_type_id])
		render 'vendor/index_with_tariffs'
	end

	def create
		@vendor = Vendor.new params[:vendor]

		render 'vendor/show'
	end

	def index
		@vendors = Vendor.all
		render 'vendor/index'
	end
end
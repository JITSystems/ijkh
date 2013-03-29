class VendorController < ApplicationController
	def index_with_tariffs
		vendors_index = Vendor.vendors_index params[:service_type_id]
		render json: vendors_index
	end
end
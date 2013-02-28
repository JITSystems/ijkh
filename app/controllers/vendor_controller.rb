class VendorController < ApplicationController
	def index_with_tariffs
		@vendors = Vendor.select("id, title").where(service_type_id: params[:service_type_id])

		render json: @vendors
	end
end
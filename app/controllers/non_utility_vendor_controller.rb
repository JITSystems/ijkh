class NonUtilityVendorController < ApplicationController
	skip_before_filter :require_auth_token
	def index_by_service_type
		@non_utility_vendors = NonUtilityVendor.where(non_utility_service_type_id: params[:non_utility_service_type_id])
		render json: @non_utility_vendors
	end

	def create
		@non_utility_vendor = NonUtilityVendorManager.create(params[:non_utility_vendor])
		p @non_utility_vendor.inspect
		if params[:picture]
			map_name = @non_utility_vendor.title
		  	name = map_name.to_s+'.png'
		  	directory = File.join('public','images','non_utility_maps', @non_utility_vendor.non_utility_service_type_id.to_s)

		  	unless File.directory?(directory)
		  	  FileUtils.mkdir_p(directory)
		  	end

		  	path = File.join(directory, name)
		  	File.open(path, "wb") { |f| f.write((params[:picture][:url]).read) }
		  	directory = File.join('images','non_utility_maps', @non_utility_vendor.non_utility_service_type_id.to_s)
		  	path = File.join(directory, name)
		  	path
		  	@non_utility_vendor.update_attribute(:picture_url, path)
		end

		render json: {}
	end
end
class NonUtilityVendorManager < ObjectManager

	def self.create(params)
		non_utility_vendor = NonUtilityVendor.create!(params[:non_utility_vendor])
		if params[:picture]
			map_name = non_utility_vendor.id
		  	name = map_name.to_s+'.png'
		  	directory = File.join('/','home','ubuntu','apps','shared','images','non_utility_maps', non_utility_vendor.non_utility_service_type_id.to_s)

		  	unless File.directory?(directory)
		  	  FileUtils.mkdir_p(directory)
		  	end

		  	path = File.join(directory, name)
		  	File.open(path, "wb") { |f| f.write(open(params[:picture][:url]).read) }
		  	directory = File.join('/','home','ubuntu','apps','shared','images','non_utility_maps', non_utility_vendor.non_utility_service_type_id.to_s)
		  	path = File.join(directory, name)
		  	path = "images/non_utility_maps/#{non_utility_vendor.non_utility_service_type_id}/#{name}"
		  	non_utility_vendor.update_attribute(:picture_url, path)
		end
		return non_utility_vendor
	end

	def self.index_by_service_type(non_utility_service_type_id)
		NonUtilityVendor.where(non_utility_service_type_id: non_utility_service_type_id)
	end
end
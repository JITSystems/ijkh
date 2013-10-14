class VendorManager < ObjectManager

	def self.index_with_data
		# Finds all service types and returns it with all related data
	end

	def self.index_with_tariffs(service_type)
		service_type.vendors.where(is_active: true)
	end

	def self.index_active
		Vendor.where(is_active: true)
	end

	def self.create(params)
		Vendor.create!(params[:vendor])
	end

	def self.fetch_by_inn(inn)
		Vendor.where("inn = ? and is_active = true", inn).first
	end
end
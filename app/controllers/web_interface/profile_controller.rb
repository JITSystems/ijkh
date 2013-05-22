class WebInterface::ProfileController < WebInterfaceController
	def show
		@places = Place.where("user_id = ? and is_active = true", current_user.id).order("id DESC")
		@place = @places.first
		@service_types = ServiceType.select("id, title").all
    	@vendors = Vendor.select("id, title, service_type_id").all
    	@tariff_templates = TariffTemplate.select("id, title, vendor_id, has_readings").where("vendor_id != 0")
	end
end
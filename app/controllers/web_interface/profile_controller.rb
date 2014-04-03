# encoding: utf-8

class WebInterface::ProfileController < WebInterfaceController
	def show
		@places = Place.where("user_id = ? and is_active = true", current_user.id).order("id DESC")
        @nsk = Place.where("user_id = ? and is_active = true and city_id = 6", current_user.id)
		@place = @places.first
		@place_id = ""
		if @place
			@place_id = @place.id
		end 

		@service_types = ServiceTypeManager.index
    	#@vendors = VendorManager.index
    	@vendors = Vendor.select("id, title, service_type_id").where("is_active = true")
    	@tariff_templates = TariffTemplate.select("id, title, vendor_id, has_readings, service_type_id")
    	@field_templates = FieldTemplateManager.index
    	@service = Service.new
    	@cities = CityManager.index
        @services = ServiceManager.index_by_place(@place) if @place
        @place_types = PlaceTypeManager.index

    	@grouped_options = Hash.new
   
    	# [v.title, v.id, {listType: 'vendor', id: v.id, serviceTypeId: v.service_type_id}]
		
    	@cities.each do |c|
    		vendors = []
    			c.vendors.where("is_active = true").each do |v|    				
    				vendors << [v.title, v.id, {listType: 'vendor', id: v.id, serviceTypeId: v.service_type_id}]
    			end
    		@grouped_options[c.title] = vendors if vendors.first
    	end    	
    		@grouped_options[""] = [["Настроить свой тариф", "", options = {listType: 'userTariff', id: 0, serviceTypeId: 0} ]]

	end

	def get_vendors

		@cities = CityManager.index
    	@grouped_options = Hash.new
		
    	@cities.each do |c|
    		vendors = []
    			c.vendors.where("is_active = true and service_type_id = ?", params[:service_type_id]).each do |v|    				
    				vendors << [v.title, v.id, {listType: 'vendor', id: v.id, serviceTypeId: v.service_type_id}]
    			end
    		@grouped_options[c.title] = vendors if vendors.first
    	end

    	@grouped_options[""] = [["Настроить свой тариф", "", options = {listType: 'userTariff', id: 0, serviceTypeId: 0} ]]

    	# render json: @grouped_options

    	respond_to do |format|
    		format.js {
				render 'web_interface/profile/get_vendors'
			}
		end


	end
	# def show
	# 	@places = Place.where("user_id = ? and is_active = true", current_user.id).order("id DESC")
	# 	@place = @places.first
	# 	@place_id = ""
	# 	if @place
	# 		@place_id = @place.id
	# 	end 

	# 	@service_types = ServiceType.select("id, title").all
 #    	@vendors = Vendor.select("id, title, service_type_id").all
 #    	@tariff_templates = TariffTemplate.select("id, title, vendor_id, has_readings").where("vendor_id != 0")
	# end
end
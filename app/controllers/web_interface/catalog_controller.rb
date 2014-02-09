class WebInterface::CatalogController < WebInterfaceController
	skip_before_filter :require_current_user
  def show
  	# get "catalog" => "web_interface/catalog#show"
  	
		@non_utility_service_type = NonUtilityServiceType.order('title asc')
    	@non_utility_vendor = NonUtilityVendor.order('title asc')
    	@non_utility_tariff = NonUtilityTariff.order('title asc')
  end
end

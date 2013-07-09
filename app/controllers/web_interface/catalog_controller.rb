class WebInterface::CatalogController < WebInterfaceController
	skip_before_filter :require_current_user
  def show
		@non_utility_service_type = NonUtilityServiceType.order('title asc')
    	@non_utility_vendor = NonUtilityVendor.order('title asc')
    	@non_utility_tariff = NonUtilityTariff.order('title asc')
  end
end

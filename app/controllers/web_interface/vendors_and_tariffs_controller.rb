# encoding: utf-8 

class WebInterface::VendorsAndTariffsController < WebInterfaceController
	skip_before_filter :require_current_user

  def show
  	# get 'vendors_and_tariffs' =>  "web_interface/vendors_and_tariffs#show"
  	
   	@vendors = VendorManager.index_active

  end

end
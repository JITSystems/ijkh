# encoding: utf-8 

class WebInterface::VendorsAndTariffsController < WebInterfaceController
	skip_before_filter :require_current_user

  def show
   	@vendors = VendorManager.index_active

  end

end
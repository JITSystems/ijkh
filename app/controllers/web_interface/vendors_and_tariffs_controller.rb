# encoding: utf-8 

class WebInterface::VendorsAndTariffsController < WebInterfaceController

  def show
   	@vendors = VendorManager.index_active
  end

end
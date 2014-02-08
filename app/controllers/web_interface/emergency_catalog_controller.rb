class WebInterface::EmergencyCatalogController < WebInterfaceController
	skip_before_filter :require_current_user
  def show

  end
end

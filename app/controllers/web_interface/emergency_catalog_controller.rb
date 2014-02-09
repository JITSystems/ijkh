class WebInterface::EmergencyCatalogController < WebInterfaceController
	skip_before_filter :require_current_user
  def show
	# get "emergency_catalog" => "web_interface/emergency_catalog#show"
  end
end

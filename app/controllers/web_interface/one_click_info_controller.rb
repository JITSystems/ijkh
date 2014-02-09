class WebInterface::OneClickInfoController < WebInterfaceController
	skip_before_filter :require_current_user
	
	def show
		# get "one_click_info" => "web_interface/one_click_info#show"
	end
end
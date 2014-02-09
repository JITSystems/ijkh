class WebInterface::AboutController < WebInterfaceController
	skip_before_filter :require_current_user
	
	def show
		# get 'about' => 'web_interface/about#show'
	end
end
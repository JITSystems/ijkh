class WebInterface::FaqController < WebInterfaceController
	skip_before_filter :require_current_user

	def show
		# get 'faq' => 'web_interface/faq#show'
		
	end
end
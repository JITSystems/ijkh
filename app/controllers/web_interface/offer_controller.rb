class WebInterface::OfferController < WebInterfaceController
	skip_before_filter :require_current_user
	
	def show
		# get 'offer' => 'web_interface/offer#show'
		
	end
end
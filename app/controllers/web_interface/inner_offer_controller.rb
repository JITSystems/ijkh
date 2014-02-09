class WebInterface::InnerOfferController < WebInterfaceController
	skip_before_filter :require_current_user

	def show
		# get 'inner_offer' => 'web_interface/inner_offer#show'
	end
end
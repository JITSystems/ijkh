class WebInterface::RedirectPageController < WebInterfaceController
	skip_before_filter :require_current_user

	def show
		# get "redirect" => 'web_interface/redirect_page#show'
		
		@url = params[:url]
		@local_url = params[:local_url]
	end
end
class WebInterface::AppDownloadController < WebInterfaceController
	skip_before_filter :require_current_user

	def show
		# get 'app_download' => 'web_interface/app_download#show'
	 
	end
end
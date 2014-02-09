class WebInterface::MainController < WebInterfaceController
	skip_before_filter :require_current_user

	def index
		# get 'main' => 'web_interface/main#index'
	end
end
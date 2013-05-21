class WebInterface::MainController < WebInterfaceController
	skip_before_filter :require_current_user

	def index
	end
end
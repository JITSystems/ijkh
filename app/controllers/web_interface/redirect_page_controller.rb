class WebInterface::RedirectPageController < WebInterfaceController
	skip_before_filter :require_current_user

	def show
		@url = params[:url]
	end
end
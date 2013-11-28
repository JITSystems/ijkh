class WebInterface::EmergencyController < WebInterfaceController
	skip_before_filter :require_current_user
  def show
		@emergency_category = EmergencyCategory.order('title asc')
    	@emergency_service = EmergencyService.order('title asc')
    	@emergency_info = EmergencyInfo.order('title asc')
  end
end

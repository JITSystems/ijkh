class WebInterface::UtilityMetricSettingsController < WebInterfaceController
	def create
		@settings = UtilityMetricSetting.where("user_id = ? and vendor_id = ?", current_user.id, params[:utility_metric_settings][:vendor_id]).first
		
		respond_to do |format|
			if @settings
				format.js {render 'web_interface/utility_metrics/create'}
			else
				format.js {render 'web_interface/utility_metrics/create'}
			end
		end
	end

	def update

	end
end
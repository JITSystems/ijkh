class WebInterface::UtilityMetricSettingsController < WebInterfaceController
	def create
		@settings = UtilityMetricSetting.where("user_id = ? and vendor_id = ?", current_user.id, params[:utility_metric_settings][:vendor_id]).first
		@vendor_id =  params[:utility_metric_settings][:vendor_id]
		@last_metric = UtilityMetric.where("user_id = ? and vendor_id = ?", current_user.id, params[:utility_metric_settings][:vendor_id]).order("created_at DESC").first
		respond_to do |format|
			format.js {render 'web_interface/utility_metrics/create'}
		end
	end

	def update

	end
end
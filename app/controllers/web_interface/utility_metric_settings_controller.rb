class WebInterface::UtilityMetricSettingsController < WebInterfaceController
	  layout 'utility_metrics'
	def create
		@settings = UtilityMetricSetting.where("user_id = ? and vendor_id = ?", current_user.id, params[:utility_metric_settings][:vendor_id]).first
		@vendor_id =  params[:utility_metric_settings][:vendor_id]
		@last_metric = UtilityMetric.where("user_id = ? and vendor_id = ?", current_user.id, params[:utility_metric_settings][:vendor_id]).order("created_at DESC").first
		respond_to do |format|
			format.js {render 'web_interface/utility_metrics/create'}
		end
	end

	def update
		UtilityMetricSetting.find(params[:id]).update_attributes(params[:utility_metric_setting])
		redirect_to utility_metrics_path
	end

	def edit
		@utility_metric_setting = UtilityMetricSetting.find(params[:id])
		@address = @utility_metric_setting.address.split(', ')
		render 'web_interface/utility_metrics/edit'
	end
end
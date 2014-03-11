class WebInterface::UtilityMetricsController < WebInterfaceController

  layout 'utility_metrics'
  def index
    @vendors = Vendor.where(service_type_id: 4)
    @utility_metrics = current_user.utility_metrics.order('created_at desc')
    render 'web_interface/utility_metrics/index'
  end

  def show
  end

  def create_unset
    metric_params = params[:utility_metrics]
    address = [metric_params[:s_address_city], metric_params[:s_address_street], metric_params[:s_address_house]].join(', ')
    address = [address, metric_params[:s_address_apt]].join(', ') if metric_params[:s_address_apt]
    
    UtilityMetricSetting.create!(address: address, 
                                energy_phase_one: metric_params[:s_energy_phase_one], 
                                energy_phase_two: metric_params[:s_energy_phase_two], 
                                energy_phase_common: metric_params[:s_energy_phase_common], 
                                water_cold: metric_params[:s_water_cold], 
                                water_hot: metric_params[:s_water_hot],
                                vendor_id: metric_params[:vendor_id],
                                user_id: current_user.id)

    UtilityMetric.create!(energy_phase_one: metric_params[:energy_phase_one_before],
                          energy_phase_two: metric_params[:energy_phase_two_before],
                          energy_phase_common: metric_params[:energy_phase_common_before],
                          water_cold: metric_params[:water_cold_before],
                          water_hot: metric_params[:water_hot_before],
                          gas: metric_params[:gas_before],
                          vendor_id: metric_params[:vendor_id],
                          user_id: current_user.id,
                          processed: false)

    UtilityMetric.create!(energy_phase_one: metric_params[:energy_phase_one],
                          energy_phase_two: metric_params[:energy_phase_two],
                          energy_phase_common: metric_params[:energy_phase_common],
                          water_cold: metric_params[:water_cold],
                          water_hot: metric_params[:water_hot],
                          gas: metric_params[:gas], 
                          vendor_id: metric_params[:vendor_id],
                          user_id: current_user.id,
                          processed: false)

    redirect_to utility_metrics_path
  end

  def create_set
    @utility_metric = UtilityMetric.create!(params[:utility_metrics].merge(user_id: current_user.id))
    redirect_to utility_metrics_path
  end

  def update
  end

  def destroy
    UtilityMetric.find(params[:id]).destroy
    redirect_to utility_metrics_path
  end

  def report
    @utility_metrics = UtilityMetric.where("vendor_id = ? and created_at > ? and created_at <= ?", params[:vendor_id], params[:from], params[:to])
    render json: @utility_metrics
  end

  def process_metric
    if params[:utility_metrics]
      params[:utility_metrics].each do |metric|
        UtilityMetric.find(metric[:id]).update_attributes(processed: metric[:processed])
      end
    end
    render json: {status: "success"}
  end

end
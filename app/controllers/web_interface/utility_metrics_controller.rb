class WebInterface::UtilityMetricsController < WebInterfaceController

  layout 'utility_metrics'
  def index
    @vendors = Vendor.where(service_type_id: 4)
    @utility_metrics = current_user.utility_metrics
    render 'web_interface/utility_metrics/index'
  end

  def show
  end

  def create
    @utility_metric = UtilityMetric.create!(params[:utility_metric])

    redirect_to utility_metrics_path
  end

  def update
  end

  def destroy
  end

  def report
    @utility_metrics = UtilityMetric.where("vendor_id = ? and created_at > ? and created_at <= ?", params[:vendor_id], params[:from], params[:to])
    render json: @utility_metrics
  end

  def process
    if params[:utility_metrics]
      params[:utility_metrics].each do |metric|
        UtilityMetric.find(metric[:id]).update_attribute(processed: metric[:processed])
      end
    end
  end
end
class ServiceTypeController < ApplicationController
  def index
	@service_types = ServiceTypeManager.index
	render 'service_type/index'
  end

  def create
	@service_type = ServiceTypeManager.create(params[:service_type])
	render 'service_type/show'
  end

  def index_user_account
  	services = Service.where("vendor_id = ? and is_active = true", params[:vendor_id]).pluck(:user_account)
  	render json: services
  end
end
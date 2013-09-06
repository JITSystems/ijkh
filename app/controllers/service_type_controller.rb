class ServiceTypeController < ApplicationController
  def index
	@service_types = ServiceTypeManager.index
	render 'service_type/index'
  end

  def create
	@service_type = ServiceTypeManager.create(params[:service_type])
	render 'service_type/show'
  end
end
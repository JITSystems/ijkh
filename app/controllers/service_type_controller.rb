class ServiceTypeController < ApplicationController
  def index
  	# GET api/1.0/servicetypes
	@service_types = ServiceTypeManager.index
	render 'service_type/index'
  end

  def create
  	# POST api/1.0/servicetype
	@service_type = ServiceTypeManager.create(params[:service_type])
	render 'service_type/show'
  end

  def terminal
    # GET api/1.0/terminal/vendors
    p @service_types = ServiceTypeManager.index
    render 'service_type/terminal'
  end
end
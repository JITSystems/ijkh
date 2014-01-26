class TariffTemplateController < ApplicationController
	
	skip_before_filter :require_auth_token

	def index
		# GET api/1.0/servicetype/:service_type_id/tarifftemplates
		@tariff_templates = TariffTemplateManager.index(params[:service_type_id])
		render 'tariff_template/index'
	end

	def create
		# POST api/1.0/tariff_template
		@tariff_template = TariffTemplateManager.create(params[:tariff_template])
		render json: @tariff_template
	end
end
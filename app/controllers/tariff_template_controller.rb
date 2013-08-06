class TariffTemplateController < ApplicationController
	def index
		@tariff_templates = TariffTemplate.where("service_type_id = ? and vendor_id = 0", params[:service_type_id])

		render 'tariff_template/index'
	end

	def show
		@tariff_template = TariffTemplate.select("id, title, has_readings").where(id: params[:tariff_id])

		render 'tariff_template/show'
	end

	def create
		@tariff_template = TariffTemplate.new(params[:tariff_template])
		@tariff_template.save
		render json: @tariff_template
	end
end
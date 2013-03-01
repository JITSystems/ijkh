class TariffTemplateController < ApplicationController
	def index
		@tariff_templates = TariffTemplate.select("id, title").where(service_type_id: params[:service_type_id])

		render json: @tariff_templates, each_serializer: TariffTemplateOnCreateUserServiceSerializer
	end
end
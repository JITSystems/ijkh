class TariffTemplateController < ApplicationController
	def index
		@tariff_templates = TariffTemplate.select("id, title").where(service_type_id: params[:service_type_id]).includes(field_templates: :field_template_list_values)

		@tariff_templates = @tariff_templates.as_json(include: 
														{ field_templates:
															{ include:
																{ field_template_list_values:
																	{ only: [:id, :value] }
																}, only: [:id, :title, :field_type]
															}
														}, only: [:id, :title] 
													)

		render json: {tariff_templates: @tariff_templates}
	end
end
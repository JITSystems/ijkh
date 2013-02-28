	class TariffController < ApplicationController
	def index
		@service = Service.select(:tariff_id).find(params[:service_id])
		@tariff = Tariff.select("id, title").where(id: @service.tariff_id).includes(tariff_template: {field_templates: :values}).where("values.tariff_id = tariffs.id")
		@tariff = (@tariff.as_json( include: 
										{ tariff_template: 
											{ include:
												{ field_templates: 
													{ include: 
														{values: 
															{only: [:id, :value]}
														}, only: [:id, :title]
													}
												}, only: [:id, :title]
											}
										}, only: [:id, :title, :owner_type, :owner_id])).first
		
		field_templates = @tariff[:tariff_template][:field_templates]

		field_templates.each do |fd|
			fd[:value] = fd[:values].first
			fd.delete(:values)
		end
		@tariff[:tariff_template][:field_templates] = field_templates

		if @tariff["owner_type"] == "Vendor"
			@vendor = Vendor.select("id, title, service_type_id").find(@tariff["owner_id"])
			@tariff.merge!(vendor: {id: @vendor.id, title: @vendor.title})
		end
		
		render json: { tariff: @tariff }
	end

end
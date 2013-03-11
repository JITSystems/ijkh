class PredefinedDataController < ApplicationController
	def index
		render json: {api: "1.0"}
	end

	def index_pre
	      	@service_types = ServiceType.select("id, title").includes(vendors: {tariffs: {tariff_template: {field_templates: :values}}}).where("values.tariff_id = tariffs.id")
			render json: 
			{ service_types: @service_types.as_json(
				include: 
					{ vendors: 
	                    { include: 
	                    	{ tariffs: 
								{ include: 
									{ tariff_template: 
										{ include: 
											{ field_templates: 
												{include: 
													{ values: {only: [:value, :tariff_id]}
													}, only: [:id, :title]
												}
											}, only: [:id, :current_value, :title]
										}
									}, only: [:title, :id, :owner_type]
								} 
							}, only: [:title, :id]
						}
					}, only: [:title, :id] )
			}
	end
end

class VendorController < ApplicationController
	def index_with_tariffs
		@vendors = Vendor.select("id, title").where(service_type_id: params[:service_type_id]).includes(tariffs: {tariff_template: {field_templates: :values}}).where("values.tariff_id = tariffs.id")

		render json: { vendors: @vendors.as_json(
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
									}, only: [:title, :id]
								} 
							}, only: [:title, :id]
						})}
	end
end
class VendorController < ApplicationController
	def index_with_tariffs
		@vendors = Vendor.select("id, title").where(service_type_id: params[:service_type_id]).includes(tariffs: {tariff_template: {field_templates: :values}}).where("values.tariff_id = tariffs.id")

		@vendors = @vendors.as_json(
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
						})
		@vendors.each do |vendor|
			vendor[:tariffs].each do |tariff|
				tariff[:tariff_template][:field_templates].each do |fd|
					fd[:value] = fd[:values].first
					fd.delete(:values)
				end
			end
		end

		render json: {vendors: @vendors}
	end
end
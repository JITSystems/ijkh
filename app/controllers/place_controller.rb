class PlaceController < ApplicationController
	def index
		@user = User.where(authentication_token: params[:auth_token]).first
		@places = @user.places.select("id, title, city, street, building, apartment").where(is_active: true).includes(services: {tariff: {tariff_template: {field_templates: [:values, :field_template_list_values, :reading_field_template]}}})
		@places =  @places.as_json(
				include: 
					{ services: 
	                    { include: 
	                    	{ tariff: 
								{ include: 
									{ tariff_template: 
										{ include: 
											{ field_templates: 
												{include: 
													[{values: {only: [:value, :tariff_id]}},
													 {field_template_list_values: {only: [:id, :value]}},
													 {reading_field_template: {only: [:id, :title]}}], only: [:id, :title]
												}
											}, only: [:id, :current_value, :title]
										}
									}, only: [:title, :id, :owner_type]
								} 
							}, only: [:title, :id]
						}
					}, only: [:title, :id] )
		
		@places.each do |place|
			@services = place[:services]
			place.delete(:services)

			@services.each do |service|
				@field_templates = service[:tariff][:tariff_template][:field_templates]
				service[:tariff][:tariff_template].delete(:field_templates)

				@field_templates.each do |ft|
					@values = ft[:values]
					ft.delete(:values)
					
					@values.delete_if do |value|
					value["tariff_id"] != service[:tariff]["id"]
					end
	
					ft[:value] = @values
				end
				service[:tariff][:tariff_template][:field_templates] = @field_templates
			end
			place[:service] = @services
		end

		render json: @places
		end

	def create
		@user = User.where(authentication_token: params[:auth_token]).first
		@place = Place.new(params[:place].merge user_id: @user.id, is_active: true)

		if @place.save
			render json: @place
		else
			render json: {error: "something went wrong"}
		end
	end 

	def update
		@user = User.where(authentication_token: params[:auth_token]).first
		@place = Place.find(params[:place_id])
      	if @place.update_attributes(params[:place])
			render json: @place
      	else
      		render json: {error: "something went wrong"}
      	end
	end
end
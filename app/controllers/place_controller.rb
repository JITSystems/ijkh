class PlaceController < ApplicationController
	def index
		@user = User.where(authentication_token: params[:auth_token]).first
		if @user then
			@places = @user.places.select("id, title, city, street, building, apartment").where(is_active: true).includes(services: {tariff: {tariff_template: {field_templates: [:values, :field_template_list_values, :reading_field_template, :meter_readings]}}})
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
														 {reading_field_template: {only: [:id, :title]}},
														 {meter_readings: {only: [:id, :reading, :created_at, :tariff_id]}}], only: [:id, :title, :is_for_calc]
													}
												}, only: [:id, :has_readings, :title]
											}
										}, only: [:title, :id, :owner_type]
									} 
								}, only: [:title, :id]
							}
						}, only: [:title, :id, :city, :street, :building, :apartment] )
			
			@places.each do |place|
				@services = place[:services]
				place.delete(:services)

				@services.each do |service|
					@field_templates = service[:tariff][:tariff_template][:field_templates]
					service[:tariff][:tariff_template].delete(:field_templates)				
					@field_templates.each do |ft|
						@values = ft[:values]
						if ft[:meter_readings]
							@meter_readings = ft[:meter_readings]
							ft.delete(:meter_readings)	
						end
						ft.delete(:values)
						
						@meter_readings.delete_if do |mr|
							mr["tariff_id"] != service[:tariff]["id"]
						end

						@values.delete_if do |value|
							value["tariff_id"] != service[:tariff]["id"]
						end

						ft[:meter_reading] = @meter_readings
						ft[:value] = @values
					end
					service[:tariff][:tariff_template][:field_templates] = @field_templates
				end
				place[:service] = @services
			end

			render json: @places

		else
			render json: {error: "user not found"}
		end
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
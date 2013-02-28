class ServiceController < ApplicationController
	def index
		@place = Place.find(params[:place_id])
		@services = Service.select("id, title, tariff_id, place_id, service_type_id").where(place_id: @place.id)
		
		render json: @services
	end

	def show

	end

	def create
		@user = User.where(authentication_token: params[:auth_token]).first
		@service = Service.new(params[:service].merge user_id: @user.id)

		if @service.save
			render json: {service: @service.as_json( except: [:created_at, :updated_at])}
		else
			render json: {error: "something went wrong"}
		end
	end

	def update_user_service
		values_array = params[:values]
		values_array.each do |value| 
		render json: { error: "something went wrong" } unless @value.save
		end

		render json: {status: "updated"}
	end

	def destroy
		@service = Service.find(params[:service_id])
		if @service.destroy
			render json: {status: "deleted"}
		else
			render json: {error: "something went wrong"}
		end
	end

	def create_user_service
		@user = User.where(authentication_token: params[:auth_token]).first
		
		@service = Service.new(params[:service].merge user_id: @user.id, place_id: params[:place_id])
		if @service.save
			@tariff = Tariff.new(params[:tariff].merge owner_id: @user.id, owner_type: "User")
			if @tariff.save
				values_array = params[:values]
				values_array.each do |value| 
					@value = Values.new(value.merge tariff_id: @tariff.id) 
					@value.save
				end
			end
			@service.update_attributes(tariff_id: @tariff.id)
		end

		render json: {user_service: @service}
	end
end
class ServiceController < ApplicationController
	def index
		@place = Place.find(params[:place_id])
		@services = Service.select("id, title, tariff_id, place_id, service_type_id, vendor_id").where(place_id: @place.id)
		
		render json: @services
	end

	def show

	end

	def create
		if params[:service][:vendor]
		@user = User.where(authentication_token: params[:auth_token]).first
		tariff_id = params[:service][:tariff][:id]
		vendor_id = params[:service][:vendor][:id]
		params[:service].delete(:tariff)
		params[:service].delete(:vendor)
		@service = Service.new(params[:service].merge user_id: @user.id, tariff_id: tariff_id, vendor_id: vendor_id)
		else

		end

		if @service.save
			render json: @service
		else
			render json: {error: "something went wrong"}
		end
	end

	def update_user_service
		field_templates = params[:service][:tariff][:tariff_template][:field_templates]
		field_templates.each do |ft|
			@value = Value.find((ft[:value].first)[:id])
			@value.update_attributes(ft[:value].first)
		end
		@service = Service.select("id, title, tariff_id, place_id, service_type_id, vendor_id").find(params[:service_id])
		render json: @service
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
		tariff = params[:service][:tariff]
		params[:service].delete(:tariff)
		@service = Service.new(params[:service].merge user_id: @user.id)

		if @service.save
			tariff_template = tariff[:tariff_template]
			tariff.delete(:tariff_template)
			@tariff = Tariff.new(tariff.merge owner_id: @user.id, owner_type: "User", tariff_template_id: tariff_template[:id])
			if @tariff.save
				field_templates = tariff_template[:field_templates]
				field_templates.each do |ft| 
					@value = Value.new(ft[:value].first.merge tariff_id: @tariff.id, field_template_id: ft[:id])
					@value.save
				end
			end
			@service.update_attributes(tariff_id: @tariff.id)
		end

		render json: @service
	end
end
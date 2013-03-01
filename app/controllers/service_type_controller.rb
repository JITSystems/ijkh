class ServiceTypeController < ApplicationController
	def index
		@service_types = ServiceType.select("id, title").all
		render json: {service_type: @service_types}
	end

	def index_non_existant
		@excluded_service_type_ids = Service.where(place_id: params[:place_id]).uniq.select(:service_type_id)
		@services = Service.where(place_id: params[:place_id])
		if @excluded_service_type_ids.blank?
			if @services.blank?
				@service_types = ServiceType.select("id, title").all
				render json: { service_type: @service_types }
			else
				render json: { service_type: []}
			end
		else
			@service_types = ServiceType.where("id NOT IN (?)", @excluded_service_type_ids.map(&:service_type_id).first).select("id, title")
			render json: { service_type: @service_types }
		end
	end

	def create
		@service_type = ServiceType.new(params[:service_type])
		if @service_type.save
			render json: @service_type
		end
	end
end
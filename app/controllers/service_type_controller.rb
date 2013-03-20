class ServiceTypeController < ApplicationController
	def index
		@service_types = ServiceType.select("id, title").all
		render json: {service_type: @service_types}
	end

	def index_non_existant
		@existant_service_type_ids = Service.where(place_id: params[:place_id]).uniq.select("service_type_id as id").map(&:id)
		@service_type_ids = ServiceType.select(:id).map(&:id)
		@non_existant_service_type_ids = @service_type_ids - @existant_service_type_ids
		@service_types = ServiceType.where(id: @non_existant_service_type_ids).select("id, title")
		render json: @service_types
	end

	def create
		@service_type = ServiceType.new(params[:service_type])
		if @service_type.save
			render json: @service_type
		end
	end
end
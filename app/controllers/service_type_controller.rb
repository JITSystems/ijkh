class ServiceTypeController < ApplicationController
	def index
		service_types = ServiceType.select.all
		render json: service_types
	end

	def index_non_existant
		existant_service_type_ids = Service.existant_service_type_ids(params[:place_id])
		service_type_ids = ServiceType.ids
		non_existant_service_type_ids = service_type_ids - existant_service_type_ids
		service_types = ServiceType.non_existant_service_types(non_existant_service_type_ids)
		render json: service_types
	end

	def create
		service_type = ServiceType.new(params[:service_type])
		if service_type.save
			render json: service_type
		end
	end
end
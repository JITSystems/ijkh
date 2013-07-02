class ServiceTypeController < ApplicationController
	def index
		@service_types = ServiceTypeManager.index
		render 'service_type/index'
	end

	def index_non_existant
		# This one's abandoned, dead and gone code. We're never gonna use it. ='(
		existant_service_type_ids = Service.existant_service_type_ids(params[:place_id])
		service_type_ids = ServiceType.ids
		non_existant_service_type_ids = service_type_ids - existant_service_type_ids
		service_types = ServiceType.non_existant_service_types(non_existant_service_type_ids)
		render json: service_types
	end

	def create
		@service_type = ServiceTypeManager.create(params[:service_type])
		render json: @service_type
	end
end
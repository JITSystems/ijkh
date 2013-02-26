class ServiceTypeController < ApplicationController
	def index
		@service_types = ServiceType.select("id, title").all
		render json: @service_types
	end

	def index_non_existant
		@excluded_service_type_ids = Service.where(place_id: params[:place_id]).uniq.select(:service_type_id)
		if @excluded_service_type_ids.blank?
			render json: { service_types: []}
		else
			@service_types = ServiceType.where("id NOT IN (?)", @excluded_service_type_ids.map(&:service_type_id).first).select("id, title")
			render json: { service_types: @service_types }
		end
	end
end
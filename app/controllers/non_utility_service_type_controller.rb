class NonUtilityServiceTypeController < ApplicationController
	skip_before_filter :require_auth_token
	def index
		@non_utility_service_types = NonUtilityServiceTypeManager.index
		render 'non_utility_service_type/index'
	end

	def show
		@non_utility_service_type = NonUtilityServiceTypeManager.get(params[:id])
		render 'non_utility_service_type/show'
	end

	def create
		@non_utility_service_type = NonUtilityServiceTypeManager.create(params[:non_utility_service_type])
		render json: "success"
	end

	def destroy
		@non_utility_service_type = NonUtilityServiceTypeManager.delete(params[:id])
		render json: "success"
	end

	def update
		@non_utility_service_type = NonUtilityServiceType.find(params[:id])
		@non_utility_service_type.update_attributes(params[:non_utility_service_type])
		render json: "success"
	end
end
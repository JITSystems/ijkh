class NonUtilityServiceTypeController < ApplicationController
	skip_before_filter :require_auth_token
	def index
		# GET api/1.0/nonutilityservicetype
		@non_utility_service_types = NonUtilityServiceTypeManager.index
		render 'non_utility_service_type/index'
	end

	def show
		# GET api/1.0/nonutilityservicetype/:id
		@non_utility_service_type = NonUtilityServiceTypeManager.get(params[:id])
		render 'non_utility_service_type/show'
	end

	def create
		# POST api/1.0/nonutilityservicetype
		@non_utility_service_type = NonUtilityServiceTypeManager.create(params[:non_utility_service_type])
		render json: "success"
	end

	def destroy
		# DELETE api/1.0/nonutilityservicetype/:id
		@non_utility_service_type = NonUtilityServiceTypeManager.delete(params[:id])
		render json: "success"
	end

	def update
		# PUT api/1.0/nonutilityservicetype/:id
		@non_utility_service_type = NonUtilityServiceTypeManager.update(NonUtilityServiceTypeManager.get(params[:id]))
		render json: "success"
	end
end
class NonUtilityServiceTypeController < ApplicationController
	skip_before_filter :require_auth_token
	def index
		@non_utility_service_types = NonUtilityServiceType.all

		render 'non_utility_service_type/index'
	end

	def create
		@non_utility_service_type = NonUtilityServiceType.new(params[:non_utility_service_type])
		@non_utility_service_type.save

		render 'non_utility_service_type/index'
	end
end
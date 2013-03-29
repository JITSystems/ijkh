class NonUtilityServiceTypeController < ApplicationController
	def index
		non_utility_service_types = NonUtilityServiceType.all

		render json: non_utility_service_types
	end
end
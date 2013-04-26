class NonUtilityServiceTypeController < ApplicationController
	def index
		@non_utility_service_types = NonUtilityServiceType.all

		render 'non_utility_service_type/index'
	end
end
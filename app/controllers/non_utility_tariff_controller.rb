class NonUtilityTariffController < ApplicationController
	skip_before_filter :require_auth_token

	def index_by_vendor
		# GET api/1.0/nonutilityvendor/:non_utility_vendor_id/nonutilitytariff
		@non_utility_tariffs = NonUtilityTariffManager.index_by_vendor(params[:non_utility_vendor_id])
		render json: @non_utility_tariffs
	end
end
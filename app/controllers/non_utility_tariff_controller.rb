class NonUtilityTariffController < ApplicationController
	skip_before_filter :require_auth_token

	def index_by_vendor
		@non_utility_tariffs = NonUtilityTariff.where(non_utility_vendor_id: params[:non_utility_vendor_id])
		render json: @non_utility_tariffs
	end
end
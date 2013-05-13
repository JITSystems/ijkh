class AnalyticController < ApplicationController
	def index
		@month_analytics = MonthAnalytic.get_annual current_user

		render 'analytic/index'
	end

	def get_detailed_payments
		@detailed_payments = DetailedPayment.get_by_service_id current_user, params[:service_id]

		render 'analytic/detailed'
	end
end
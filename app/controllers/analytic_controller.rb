class AnalyticController < ApplicationController
	def index
		# GET api/1.0/annualanalytic
		@month_analytics = MonthAnalytic.get_annual current_user
		render 'analytic/index'
	end

	def get_detailed_payments
		# GET api/1.0/service/:service_id/paymenthistories
		@detailed_payments = DetailedPayment.get_by_service_id(current_user, params[:service_id], params[:month])
		render 'analytic/detailed'
	end
end

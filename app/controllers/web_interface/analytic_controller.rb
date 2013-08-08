class WebInterface::AnalyticController < WebInterfaceController
	#require 'csv'
	def show
		@payment_histories = PaymentHistory.all

		@month_analytics = MonthAnalytic.get_annual current_user

		#@detailed_payments = DetailedPayment.get_by_service_id(current_user, params[:service_id], params[:month])

	end
end
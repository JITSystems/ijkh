class WebInterface::AnalyticController < WebInterfaceController
	#require 'csv'
	def show
		@payment_histories = PaymentHistory.all

		@month_analytics = MonthAnalytic.get_annual current_user

		#@detailed_payments = DetailedPayment.get_by_service_id(current_user, params[:service_id], params[:month])
		@csv_string = CSV.generate do |csv|
    		csv << ["row", "of", "CSV", "data"]
    		csv << ["another", "row"]
    		# ...
  		end
	end
end
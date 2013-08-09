# encoding: utf-8

class WebInterface::AnalyticController < WebInterfaceController
	#require 'csv'
	def show

		@monthA = ["Январь","Февраль","Март","Апрель","Май","Июнь","Июль","Август","Сентябрь","Октябрь","Декабрь"]

		@payment_histories = PaymentHistory.all

		@month_analytics = MonthAnalytic.get_annual current_user

		@month_total = 0.0
		@month_analytics.each do |m_a|
			@month_total += m_a.amount.to_f
		end

		

		#@detailed_payments = DetailedPayment.get_by_service_id(current_user, params[:service_id], params[:month])

	end
end
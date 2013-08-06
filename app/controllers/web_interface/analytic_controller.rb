class WebInterface::AnalyticController < WebInterfaceController
	def show
			@payment_histories = PaymentHistory.all
		
	end
end
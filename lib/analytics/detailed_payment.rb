class DetailedPayment
	attr_accessor :id, :title, :amount, :updated_at, :tariff_title, :service_id

	def initialize params
		@id = params[:id]
		@title = params[:title]
		@amount = params[:amount]
		@updated_at =  params[:updated_at]
		@tariff_title = params[:tariff_title]
		@service_id = params[:service_id]
	end

	def self.get_by_service_id user, service_id
		payment_histories = PaymentHistory.where("user_id = ? and service_id = ?", user.id, service_id).select("id, amount, po_date_time, service_id")
		detailed_payments = []

		service = Service.find(service_id)

		payment_histories.each do |payment_history|

			detailed_payment_params = {
				id: 			payment_history.id,
				title: 			service.title,
				amount: 		payment_history.amount,
				tariff_title: 	service.tariff.title,
				updated_at: 	payment_history.po_date_time,
				service_id: 	service.id
			}

			detailed_payment = DetailedPayment.new(detailed_payment_params)
			detailed_payments << detailed_payment
		end

		return detailed_payments
	end
end
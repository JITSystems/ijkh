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

	def self.get_by_service_id user, service_id, month=nil
		if month
			analytics = Analytic.where("user_id = ? and service_id = ? and extract(month from updated_at) = ?", user.id, service_id, month).select("id, amount, updated_at, service_id, service_title, tariff_title")
		else
			analytics = Analytic.where("user_id = ? and service_id = ?", user.id, service_id).select("id, amount, updated_at, service_id, service_title, tariff_title")
		end
		detailed_payments = []

		analytics.each do |analytic|

			detailed_payment_params = {
				id: 			analytic.id,
				title: 			analytic.service_title,
				amount: 		FloatModifier.modify(analytic.amount).to_s,
				tariff_title: 	analytic.tariff_title,
				updated_at: 	analytic.updated_at,
				service_id: 	analytic.service_id
			}

			detailed_payment = DetailedPayment.new(detailed_payment_params)
			detailed_payments << detailed_payment
		end

		return detailed_payments
	end
end
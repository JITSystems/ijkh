class ServiceAnalytic
	attr_accessor :title, :amount, :last_update_date, :tariff_title, :service_id
	def initialize params
		@service_id = params[:service_id]
		@title = params[:title]
		@last_update_date = params[:last_update_date]
		@tariff_title = params[:tariff_title]
		@amount = calculate_amount @service_id, params[:month]
	end

	def self.get_by_place_id place_id, month
		services = Analytic.where(place_id: place_id).select(:service_id).map(&:service_id)
		service_analytics = []
		services.each do |service_id|
			service_analytic = get_by_service service_id, month
			unless service_analytic.amount.to_i == 0
				service_analytics << service_analytic
			end
		end
		service_analytics
	end

	def self.get_by_service service_id, month
		
		analytic = Analytic.where(service_id: service_id).limit(1).first

			service_analytic_params = {
				service_id: 		analytic.service_id,
				title: 		 		analytic.service_title,
				tariff_title: 		analytic.tariff_title,
				last_update_date: 	get_last_payment(service_id, month),
				month: 				month
			}

			service_analytic = ServiceAnalytic.new(service_analytic_params)
			return service_analytic
	end
		
	def self.get_last_payment service_id, month
		payment = Analytic.where("service_id = ? and  extract(month from updated_at) = ?", service_id, month).select("service_id, updated_at").uniq.order('updated_at DESC').limit(1).first
		if payment
			return payment.updated_at
		else
			return nil
		end
	end

	private


	def calculate_amount service_id, month
		analytics = Analytic.where("service_id = ? and status = 1 and extract(month from updated_at) = ?", service_id, month).select("amount, service_id, recipe_id, status").uniq
		amount = 0.0
		analytics.each do |analytic|
			amount += analytic.amount.to_f
		end
		return amount
	end

end
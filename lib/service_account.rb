class ServiceAccount

		attr_accessor 	:title, :tariff_title, :amount, :last_update_date, :account_id,
						:status, :is_user, :has_readings, :service_id, :merchant_id

	def initialize params
		@title = params[:title]
		@amount = params[:amount]
		@tariff_title = params[:tariff_title]
		@last_update_date = params[:last_update_date]
		@account_id = params[:account_id]
		@status = params[:status]
		@is_user = params[:is_user]
		@has_readings = params[:has_readings]
		@service_id = params[:service_id]
	end

	def self.get_by_place_id place_id, status
		services = Service.where(place_id: place_id).select(:id).map(&:id)
		service_accounts = []
		services.each do |service_id|
			service_account = get_by_service service_id
			service_accounts << service_account
		end
		service_accounts
	end

	def self.get_by_service service_id
		
		service = Service.find(service_id)

		if service.tariff.owner_type == "User"
				is_user = true
				merchant_id = nil
			else
				is_user = false
				merchant_id = service.vendor.merchant_id
		end

			service_account_params = {
				service_id: 		service.id,
				title: 				service.title,
				tariff_title: 		service.tariff.title,
				amount: 			service.account.amount,
				last_update_date: 	service.account.updated_at,
				account_id: 		service.account.id,
				status: 			service.account.status,
				has_readings: 		service.tariff.has_readings,
				is_user: 			is_user,
				merchant_id: 		merchant_id
			}

			service_account = ServiceAccount.new(service_account_params)
			return service_account
	end
end
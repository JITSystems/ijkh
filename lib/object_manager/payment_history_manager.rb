class PaymentHistoryManager < ObjectManager
	def self.create_successful
	end

	def self.create_failed
	end

	def self.get_by_service(service)
		service.payment_histories
	end
end
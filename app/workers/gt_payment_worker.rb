# encoding: utf-8
class GtPaymentWorker
	include Sidekiq::Worker

	def perform(service_id, recipe_id, amount)
		service = Service.find(service_id)
		user_account = service.user_account
		gt = GlobalTelecom.new(user_account, recipe_id, amount)
		amount = gt.pay
	end

end
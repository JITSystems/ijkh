# encoding: utf-8
class GtPaymentWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false

	def perform(service_id, recipe_id, amount, user_account = nil)
    if service_id
		  service = Service.find(service_id)
		  user_account = service.user_account
    end
    
		gt = GlobalTelecom.new(user_account, recipe_id, amount)
		amount = gt.pay
	end

end
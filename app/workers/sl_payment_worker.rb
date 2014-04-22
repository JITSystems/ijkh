# encoding: utf-8
class SlPaymentWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false

	def perform(service_id, recipe_id, amount, user_account = nil)
    if service_id
		  service = Service.find(service_id)
		  user_account = service.user_account
    end

    sl = SamaraLan.new(user_account, recipe_id, amount)
		sl.pay
	end

end
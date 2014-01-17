# encoding: utf-8
class SlPaymentWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false

	def perform(service_id, recipe_id, amount)
		service = Service.find(service_id)
		user_account = service.user_account
		sl = SamaraLan.new(user_account, recipe_id, amount)
		sl.pay
	end

end
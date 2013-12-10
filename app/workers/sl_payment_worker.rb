# encoding: utf-8
class SlPaymentWorker
	include Sidekiq::Worker

	def perform(user_id, recipe_id, amount)
		services = Service.where('user_id = ? and vendor_id = 135 and is_active = true', user_id)
		services.each do |service|
			user_account = service.user_account
			
			sl = SamaraLan.new(user_account, recipe_id, amount)
			sl.pay
		end
	end

end
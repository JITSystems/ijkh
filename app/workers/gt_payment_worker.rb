# encoding: utf-8
class GtPaymentWorker
	include Sidekiq::Worker

	def perform(user_id, recipe_id)
		services = Service.where("user_id = ? and vendor_id = 121 and is_active = true", user_id)
		services.each do |service|
			user_account = service.user_account
			
			gt = GlobalTelecom.new(user_account, recipe_id)
			amount = gt.pay
		end
	end

end
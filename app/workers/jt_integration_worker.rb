# encoding: utf-8
class JtIntegrationWorker
	include Sidekiq::Worker

	def perform(user_id)
		services = Service.where("user_id = ? and vendor_id = 16 and is_active = true", user_id)
		services.each do |service|
			user_account = service.user_account

			osmp = Osmp.new(user_account, DateTime.now.to_s(:number))
			amount = osmp.check

			amount = (amount.to_s)[1..-1] if amount.to_f < 0.0
			
			account = service.account
			account.update_attributes!(amount: amount, status: -1) if amount && amount.to_f > 0.0
		end
	end

end
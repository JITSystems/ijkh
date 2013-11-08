# encoding: utf-8
class JtIntegrationWorker
	include Sidekiq::Worker

	def perform(user_id, services)
		services.each do |service|
			user_account = service.user_account
			amount = Osmp.check(user_account, DateTime.now.to_s(:number))
			amount = (amount.to_s)[1..-1] if amount.to_f < 0.0
			account = service.account
			if amount && amount.to_f > 0.0
				account.update_attributes!(amount: amount, status: -1)
			end
		end
	end

end
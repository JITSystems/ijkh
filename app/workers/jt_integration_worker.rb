# encoding: utf-8
class JtIntegrationWorker
	include Sidekiq::Worker

	def perform(user_id, user_account)
		amount = Osmp.check(user_id, user_account, DateTime.now.to_s(:number))
		service = Service.where("user_account = ? and vendor_id = 16 and user_id = ?", user_account, user_id).first
		account = service.account
		if amount && amount.to_f > 0
			account.update_attributes!(amount: amount, status: -1)
		end
	end

end
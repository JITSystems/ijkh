# encoding: utf-8
class JtIntegrationWorker
	include Sidekiq::Worker

	def perform(user_id, user_account, amount)
		service = Service.where("user_account = ? and vendor_id = 16 and user_id = ?", user_account, user_id).first
		account = service.account
		account.update_attributes!(amount: amount, status: -1)
	end

end
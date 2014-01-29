# encoding: utf-8
class CraftSPaymentWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false

	def perform(service_id, recipe_id, amount)
		service = Service.find(service_id)
		tariff_template_id = service.tariff.tariff_template_id
		amount = amount.to_f*100
		case tariff_template_id.to_i
		when 153
			account_type = "inet"
		when 158
			account_type = "voip"
		else
			account_type = nil
			raise "No account type"
		end
		user_account = service.user_account
		cs = CraftS.new(user_account, DateTime.now.strftime("%Y-%m-%d %H:%M:%S"), account_type, amount, recipe_id)
		cs.pay
	end

end
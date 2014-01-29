# encoding: utf-8
class CraftSIntegrationWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false

	def perform(user_id)
		services = Service.where("user_id = ? and vendor_id = 165 and is_active = true", user_id)
		services.each do |service|
			user_account = service.user_account

			tariff_template_id = service.tariff.tariff_template_id
			case tariff_template_id.to_i
			when 153
				account_type = "inet"
			when 158
				account_type = "voip"
			else
				account_type = nil
				raise "No account type"
			end

			cs = CraftS.new(user_account, DateTime.now.strftime("%Y-%m-%d %H:%M:%S"), account_type)
			cs_check = cs.check
			if cs_check
				if cs_check[:debt]
					amount = cs.check[:debt]
				else
					amount = 0.0
				end
			else
				amount = 0.0
			end

			if amount.to_f < 0.0
				amount = (amount.to_s)[1..-1] if amount.to_f < 0.0
				account = service.account
				account.update_attributes!(amount: amount, status: -1) if amount
			end
		end
	end

end
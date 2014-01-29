# encoding: utf-8
class JtIntegrationWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false

	def perform(user_id)
		services = Service.where('user_id = ? and vendor_id = 16 and is_active = true', user_id)
		services.each do |service|
			user_account = service.user_account
			if service.tariff_id
				tariff_template_id = service.tariff.tariff_template_id

				case tariff_template_id.to_i
				when 157
					prefix = "1"
				when 155
					prefix = "2"
				when 156
					prefix = "3"
				else
					prefix = nil
					raise "No prefix"
				end

				osmp = Osmp.new(user_account, DateTime.now.to_s(:number), prefix)
				amount = osmp.check

				if amount.to_f < 0.0
					amount = (amount.to_s)[1..-1] if amount.to_f < 0.0
					account = service.account
					account.update_attributes!(amount: amount, status: -1) if amount
				end
			end
		end
	end

end
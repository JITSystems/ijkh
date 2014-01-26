class AccountManager < ObjectManager

	def self.create(params, user, service)
		account_params = {
			place_id: 	params[:service][:place_id],
			user_id: 	user.id,
			amount: 	0.0,
			service_id: service.id,
			status: 	1
			}

		account = Account.create!(account_params)
	end

	def self.fetch_by_service(service_id)
		Account.where(service_id: service_id).first
	end

	def self.update_status(account)
		status = account.amount <= 0.0 ? 1 : -1 
		account.update_attribute(:status, status)
	end

	def self.new_recurrent(service)
		account = service.account
		field = service.tariff.fields.first
		amount = field.value
		updater = AmountUpdater.new(account)
		updater.set_to(amount)
		account.update_attribute(:status, -1)
		return account
	end

	def self.hand_switch(user, account, amount)
		# Nullifies account amount
		amount ||= account.amount
		amount = FloatModifier.modify(amount)
		account.update_attributes(status: 1, amount: "0.00")
		
		# Creates fake recipe	
		recipe = RecipeManager.new
		recipe = recipe.create(account.service, amount)

		# Creates fake payment history
		PaymentHistoryManager.create_fake(recipe)

		# Creates analytics entry
		AnalyticManager.create(recipe, amount)
	end

	def self.paid_index(user)
		place_accounts = []

		places = user.places.where(is_active: true)
		
		places.each do |p|
			service_accounts = []
			place_amount = 0

			services = p.services.where(is_active: true)
			
			services.each do |s|
				
				if s.tariff.owner_type == "User"
					is_user = true
					merchant_id = nil
					psk = nil
				else
					is_user = false
					merchant_id = s.vendor.merchant_id
					psk = s.vendor.psk
				end

				account = s.account if s.account.status == 1
				if account
					service_account =  {
						title: s.title,
						amount: FloatModifier.modify(account.amount).to_s,
						tariff_title: s.tariff.title,
						account_id: account.id,
						status: 1,
						is_user: is_user,
						merchant_id: merchant_id,
						psk: psk,
						service_id: s.id,
						has_readings: s.tariff.has_readings,
						last_update_date: s.account.updated_at
					}

					service_accounts << service_account
					place_amount += account.amount
				end
			end

			place_account = {
				place_account: {
				title: p.title,
				amount: FloatModifier.modify(place_amount).to_s,
				place_id: p.id,
				service_account: service_accounts
				}
			}
			place_accounts << place_account if service_accounts != []
		end

		{place_accounts: place_accounts}
	end

	def self.unpaid_index(user)
		place_accounts = []

		places = user.places.where(is_active: true)
		
		places.each do |p|
			service_accounts = []
			place_amount = 0

			services = p.services.where(is_active: true)
			
			services.each do |s|
				
				if s.tariff.owner_type == "User"
					is_user = true
					merchant_id = nil
					psk = nil
				else
					is_user = false
					merchant_id = s.vendor.merchant_id
					psk = s.vendor.psk
				end

				account = s.account if s.account.status == -1
				if account
					service_account =  {
						title: s.title,
						amount: FloatModifier.modify(account.amount).to_s,
						tariff_title: s.tariff.title,
						account_id: account.id,
						status: -1,
						is_user: is_user,
						merchant_id: merchant_id,
						psk: psk,
						service_id: s.id,
						has_readings: s.tariff.has_readings,
						last_update_date: s.account.updated_at
					}

					service_accounts << service_account
					place_amount += account.amount
				end
			end

			place_account = {
				place_account: {
				title: p.title,
				amount: FloatModifier.modify(place_amount).to_s,
				place_id: p.id,
				service_account: service_accounts
				}
			}
			place_accounts << place_account if service_accounts != []
		end

		{place_accounts: place_accounts}
	end
end
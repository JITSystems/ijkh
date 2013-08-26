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

	def self.update_status(account)
		status = account.amount <= 0.0 ? 1 : -1 
		account.update_attribute(:status, status)
	end

	def self.new_recurrent(service)
		account = service.account
		if account
			field = service.tariff.fields.first
			amount = field.value
			updater = AmountUpdater.new(account)
			updater.set_to(amount)
		end
		account
	end

	def self.hand_switch(user, account, amount)
		# Nullifies account amount
		amount ||= account.amount
		amount = FloatModifier.modify(amount)
		account.update_attributes(status: 1, amount: "0.00")
		
		# Creates fake recipe	
		recipe = RecipeManager.new
		recipe.create(account.service, amount)

		# Creates fake payment history
		PaymentHistoryManager.create_fake(recipe)

		# Creates analytics entry
		AnalyticManager.create(recipe, amount)
	end

	
end
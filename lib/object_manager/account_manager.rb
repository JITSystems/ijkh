class AccountManager < ObjectManager

	def self.create(params, user, service)
		account = Account.create!(AccountParams.create(params, user, service))
	end

	def self.set_amount_to(account, amount)
		account.update_attributes(amount: amount)
		update_status(account)
	end

	def self.increase_amount(account, increase)
		current_value = account.amount
		account.update_attributes(amount: current_value - increase)
		update_status(account)
	end

	def self.decrease_amount(account, decrease)
		current_value = account.amount
		account.update_attributes(amount: current_value + decrease)
		update_status(account)
	end

	protected

	def self.update_status(account)
		if account.amount <= 0.0
			account.update_attributes(status: 1)
		end
	end
	
end
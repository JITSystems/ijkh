class AccountManager < ObjectManager

	def self.create(params, user, service)
		account_params = {
			place_id: 	params[:service][:place_id],
			user_id: 	user.id,
			amount: 	0.0,
			service_id: service.id
			}

		account = Account.create!(account_params)
	end

	def self.update_status(account)
		if account.amount <= 0.0
			account.update_attributes(status: 1)
		end
	end
	
end
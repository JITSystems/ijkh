class AccountManager < ObjectManager

	def self.create(params, user, service)
		account = Account.create!(AccountParams.create(params, user, service))
	end
	
end
class PaymentHistoryManager < ObjectManager
	def self.create_successful(params)
		# Creates successful payment history
		payment_history = PaymentHistory.create!(payment_history_params(params).merge!(status: 1))
		
		# Adds new card
		if params[:RebillAnchor]
			# user_id is passed in params hash because 
			# current_user object is not availible 
			# for PayOnline callback operation
			card_params = {
				rebill_anchor: 		params[:RebillAnchor],
				card_title: 		params[:CardNumber],
				user_id: 			params[:user_id]
			}
			card = CardManager.create(card_params)
		end
		
		# Updates account amount
		recipe = RecipeManager.get(params[:OrderId])
		account = recipe.service.account
		updater = AmountUpdater.new(account)
		updater.decrease(recipe.amount)
		AccountManager.update_status(account)

		return payment_history
	end

	def self.create_failed(params)
		# Creates failed payment history
		payment_history = PaymentHistory.create!(payment_history_params(params).merge!(status: -1))
		recipe = RecipeManager.get(params[:OrderId])
		account = recipe.service.account
		AccountManager.update_status(account)

		return payment_history
	end

	def self.get_by_service(service)
		service.payment_histories
	end

	def self.create_fake(recipe)
		service_id = recipe.service_id ? recipe.service_id : 0
		user_id = recipe.service_id ? recipe.service.user.id : 0

		payment_history_params = {
			amount: 				amount, 
			currency: 				"RUB", 
			user_id: 				user_id,
			payment_type: 			"0",
			status: 				1,
			service_id: 			service_id,
			recipe_id: 				recipe.id,
			po_date_time: 			DateTime.now
		}
		
		payment_history = PaymentHistory.create!(payment_history_params)
	end

	protected

	def self.payment_history_params(params)
		# params hash:
		# 	DateTime
		# 	TransactionID 
		# 	OrderId 
		# 	Amount 
		# 	Currency 
		# 	CardHolder 
		# 	CardNumber 
		# 	Country 
		# 	City 
		# 	ECI
		# 	user_id

		recipe = RecipeManager.get(params[:OrderId])
		service_id = recipe.service_id ? recipe.service_id : 0

		{
			po_date_time: 			params[:DateTime], 
			po_transaction_id: 		params[:TransactionID], 
			recipe_id: 				params[:OrderId].to_i, 
			amount: 				params[:Amount], 
			currency: 				params[:Currency], 
			card_holder: 			params[:CardHolder], 
			card_number: 			params[:CardNumber], 
			country: 				params[:Country], 
			city: 					params[:City], 
			eci: 					params[:ECI],
			user_id: 				params[:user_id].to_i,
			payment_type: 			"1",
			service_id: 			service_id
		}
	end
end
module PaymentHistoriesRepository
	def create_payment_history params
		if params[:action] == "fail"
			payment_history = create_failed params
		else
			payment_history = create_successful params
		end
		return payment_history
	end
	
	private

	def pack_params params
		payment_history_params = {
			po_date_time: 			params[:DateTime], 
			po_transaction_id: 		params[:TransactionID], 
			recipe_id: 				params[:OrderId], 
			amount: 				params[:Amount], 
			currency: 				params[:Currency], 
			card_holder: 			params[:CardHolder], 
			card_number: 			params[:CardNumber], 
			country: 				params[:Country], 
			city: 					params[:City], 
			eci: 					params[:ECI],
			user_id: 				params[:user_id],
			type: 					1
		}

		return payment_history_params
	end

	def create_successful params
		payment_history_params = pack_params params
		payment_history_params.merge status: 1
		payment_history = PaymentHistory.new(payment_history_params)
		payment_history.save

		logger.info params[:RebillAnchor].inspect
		
		if params[:RebillAnchor]
			# user_id is passed in params hash because 
			# current_user object is not availible 
			# for PayOnline callback operation
			card_params = {
				rebill_anchor: 		params[:RebillAnchor],
				card_title: 		params[:CardNumber],
				user_id: 			params[:user_id]
			}
			card = Card.create_card card_params
		end

		service_id = Recipe.get_service_id payment_history_params[:recipe_id]

		recipe = Recipe.find(payment_history_params[:recipe_id])

		account = Account.update_account_amount service_id, payment_history_params[:amount], recipe.amount

		if account[:amount] <= 0
			
			switch_status_params = {
				account_id: account[:account_id],
				status: 1
			}

			Account.switch_status switch_status_params
		else
			switch_status_params = {
				account_id: account[:account_id],
				status: -1
			}

			Account.switch_status switch_status_params
		end

		return payment_history
	end

	def create_failed params
		payment_history_params = pack_params params
		payment_history_params.merge status: -1
		payment_history = PaymentHistory.new(payment_history_params)
		payment_history.save

		return payment_history
	end
end
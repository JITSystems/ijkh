# encoding: utf-8 
module AccountsRepository

	def index_place_account user, status
		place_accounts = PlaceAccount.get_by_user_id user.id, status
	end

	def update_account_amount service_id, amount_subtrahend, amount
		account = fetch_account_by_service service_id

		amount = check_comma ammount
		amount_subtrahend = check_comma amount_subtrahend

		amount = account.amount.to_f - amount_subtrahend.to_f
		amount = amount.round(2)
		if amount < 0.0
			amount = 0.0
		end

		account.update_attributes(amount: amount)
		return {amount: amount, account_id: account.id}
	end


	def new_account params
		account = fetch_account_by_service params[:service_id]

		if account
			amount_params = {
				field_id: params[:field_id],
				reading: params[:reading],
				prev_reading: params[:prev_reading]
			}
			update_amount account, amount_params
		end

		account
	end

	def new_recurrent_account params
		account = fetch_account_by_service params[:service_id]
		
		service = Service.find(params[:service_id])
		
		field = service.tariff.fields.first

		if account
			amount_params = {
				field_id: field.id,
				reading: 2,
				prev_reading: 1
			}
			update_amount account, amount_params
		end
	end
	
	def hand_switch user, params
		account = self.find(params[:account_id])
		amount = account.amount
		amount = check_comma amount

		if account.update_attributes(status: 1, amount: "0.00")
			
			currency = "RUB"
			
			recipe_params = {
				amount: 				amount, 
				currency: 				currency, 
				user_id: 				user.id,
				service_id: 			account.service_id,
				account_id: 			account.id
			}

			recipe = Recipe.new(recipe_params)
			recipe.save

			payment_history_params = {
				amount: 				amount, 
				currency: 				currency, 
				user_id: 				user.id,
				payment_type: 			"0",
				status: 				1,
				service_id: 			account.service_id,
				recipe_id: 				recipe.id
			}

			service = recipe.service

			service_id = service.id
			service_title = service.title
			place_id = service.place.id
			place_title = service.place.title
			tariff_title = service.tariff.id


			analytic_params = {
				amount: 			amount,
				user_id: 			user.id,
				service_id: 		service_id,
				place_id: 			place_id,
				service_title: 		service_title,
				place_title: 		place_title,
				tariff_title: 		tariff_title
			}
			
			analytic = Analytic.new(analytic_params)
			analytic.save

			payment_history = PaymentHistory.new(payment_history_params)
			payment_history.save

			payment_history.update_attributes(po_date_time: payment_history.updated_at)
		end
	end

	def switch_status params
		account = self.find(params[:account_id])
		if account.update_attributes(status: params[:status])
			{status: "updated"}
		else
			{error: "something went wrong"}
		end
	end

private

	def check_comma amount
		amount = amount.to_s
		if amount.index(',')
			amount = amount.split(',')
			amount_str = amount.first + '.' + amount.last
		else 
			amount_str = amount
		end
		return amount_str
	end

	def calculate_amount value, reading, prev_reading
		
		reading = check_comma reading
		prev_reading = check_comma prev_reading
		value = check_comma value

		reading_delta = reading.to_f - prev_reading.to_f
		
		amount = reading_delta*value.to_f
		
		format_amount amount.round(2)
	end

	def format_amount amount

		amount = amount.to_s.split(".")
		if amount.last =~ /\d\d/
			amount_str = amount.first + "." + amount.last 
		else
			amount_str = amount.first + "." + amount.last + "0"
		end
		amount_str
	end

	def update_amount account, amount_params
		
		value = Field.get_value amount_params[:field_id]
		value = check_comma value

		has_readings = Field.find(amount_params[:field_id]).tariff.has_readings

		reading = amount_params[:reading]
		prev_reading = amount_params[:prev_reading]

		reading = check_comma reading
		prev_reading = check_comma prev_reading

		amount = calculate_amount value, reading, prev_reading

		if has_readings
			old_amount = account.amount
			old_amount = check_comma old_amount

			amount = amount.to_f + old_amount.to_f
			account.update_attributes(amount: amount.to_s, status: '-1')
		else
			account.update_attributes(amount: amount, status: '-1')
		end
			account
	end

	def fetch_account_by_service service_id
		account = self.where(service_id: service_id).first
	end
end
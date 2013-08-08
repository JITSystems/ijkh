module RecipesRepository

	def create_recipe user, params
		po_tax = 0
		service_tax = 0
		total = 0.0
		amount = (check_comma params[:amount]).to_f
		if amount < 500.00
			po_tax = 0
			service_tax = po_tax + round_up(0.03*amount).round(2)
			total = service_tax + amount
		else
			service_tax = round_up(0.03*amount).round(2)
			po_tax = 0
			total = service_tax + amount
		end

		vendor = Service.find(params[:service_id]).vendor

		if vendor.id == 5 || vendor.id == 40 || vendor.id == 43 || vendor.id == 44
			po_tax = 0
			service_tax = 0
			total = service_tax + amount
		end

		if user.id == 21
			total = total.ceil
			unless total%2 == 0
				total = total + 1
			end
			total = total.to_f
		end
		
		currency = "RUB"

		total = format_amount total

		recipe_params = {
			amount: amount.to_f,
			service_id: params[:service_id],
			account_id: params[:account_id],
			user_id: user.id,
			total: total.to_s,
			po_tax: po_tax.to_s,
			service_tax: service_tax.to_s,
			currency: currency
		}

		recipe = Recipe.new(recipe_params)
		recipe.save
		return recipe
	end

	def show_last user, service_id
		where("user_id = ? and service_id = ?", user.id, service_id).order('created_at DESC').limit(1).first
	end

	def get_service_id recipe_id
		recipe = Recipe.find(recipe_id)
		return recipe.service_id
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
		return round_up(amount_str.to_f).to_s
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

	def round_up amount
		amount = (amount*100).ceil/100.0
		return amount
	end

end
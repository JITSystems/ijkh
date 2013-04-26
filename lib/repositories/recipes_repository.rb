module RecipesRepository

	def create_recipe user, params
		amount = params[:amount].to_f
		if amount < 500.00
		po_tax = 3
		service_tax = 0.015*amount
		total = po_tax + service_tax + amount
		else
			service_tax = 0.03*amount
			po_tax = 0
			total = service_tax + amount
		end
		currency = "RUB"

		recipe_params = {
			amount: amount.to_s,
			service_id: params[:service_id],
			account_id: params[:account_id],
			user_id: user.id,
			total: total.to_s,
			po_tax: po_tax.to_s,
			service_tax: service_tax.to_s,
			currency: currency
		}

		recipe = Recipe.new(recipe_params)
	end

	def show_last user, service_id
		where("user_id = ? and service_id = ?", user.id, service_id).order('created_at DESC').limit(1)
	end
end
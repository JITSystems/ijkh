module AnalyticsRepository
	def create_analytic params
		amount = params[:Amount]
		recipe = Recipe.find(params[:OrderId])
		if recipe
			service_id = recipe.service_id
			service_title = recipe.service.title
			place_id = recipe.service.place.id
			place_title = recipe.service.place.title
			tariff_title = recipe.service.tariff.title
		else
			service_id = 0
			place_id = 0
			service_title = "NaN"
			place_title = "NaN"
			tariff_title = "NaN"
		end

		analytic_params = {
			user_id: 			params[:user_id],
			service_id: 		service_id,
			place_id: 			place_id,
			service_title: 		service_title,
			place_title: 		place_title,
			tariff_title: 		tariff_title,
			amount: 			amount
		}

		analytic = Analytic.new(analytic_params)
		analytic.save
	end
end
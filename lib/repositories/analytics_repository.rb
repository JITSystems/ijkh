module AnalyticsRepository
	def create_analytic params
		amount = params[:Amount]
		recipe = Recipe.find(params[:OrderId])
		if recipe
			service_id = recipe.service_id
			service_title = recipe.service.title
			place_id = service.place.id
			place_title = service.place.title
			tariff_title = service.tariff.title
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
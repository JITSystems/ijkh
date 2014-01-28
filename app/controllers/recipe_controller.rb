class RecipeController < ApplicationController
	def create
		# POST api/1.0/service/:service_id/recipe
		@recipe = RecipeManager.new
		@recipe = @recipe.create(ServiceManager.get(params[:service_id]), params[:amount])
		render json: {recipe: @recipe}
	end

	def show_last
		# GET api/1.0/service/:service_id/lastrecipe
		@recipe = RecipeManager.show_last(current_user, params[:service_id])
		render 'recipe/show'
	end
end
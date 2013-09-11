class RecipeController < ApplicationController
	def create
		@recipe = Recipe.create_recipe current_user, params
		render 'recipe/show'
	end

	def show_last
		@recipe = Recipe.show_last current_user, params[:service_id]
		render 'recipe/show'
	end
end
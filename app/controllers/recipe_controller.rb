class RecipeController < ApplicationController
	def create
		@recipe = RecipeManager.new
		@recipe = @recipe.create(ServiceManager.get(params[:service_id]), params[:amount])
<<<<<<< HEAD
		logger.info @recipe.inspect
		render 'recipe/show'
=======
		render json: {recipe: @recipe}
>>>>>>> eaaf101df3a264e1a08fadf125da2cfa17765c75
	end

	def show_last
		@recipe = RecipeManager.show_last(current_user, params[:service_id])
		render 'recipe/show'
	end
end
class FreelanceCategoryController < ApplicationController
	def index
		@freelance_categories = FreelanceCategoryManager.index
		render 'freelance_category/index'
	end

	def create
		@freelance_category = FreelanceCategoryManager.create(params[:freelance_category])
		render json: {status: "success"}
	end
end
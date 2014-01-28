class FreelanceCategoryController < ApplicationController
	def index
		# GET api/1.0/freelancecategory
		@freelance_categories = FreelanceCategoryManager.index
		render 'freelance_category/index'
	end

	def create
		# POST api/1.0/freelance_category/create
		@freelance_category = FreelanceCategoryManager.create(params[:freelance_category])
		render json: {status: "success"}
	end
end
class FreelanceCategoryController < ApplicationController
	def index
		@freelance_categories = FreelanceCategoryManager.index
		render 'freelance_category/index'
	end
end
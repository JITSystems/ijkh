class FreelanceCategoryController < ApplicationController
	def index
		@freelance_categories = FreelanceCategory.all

		render 'freelance_category/index'
	end
end
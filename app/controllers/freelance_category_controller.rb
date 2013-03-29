class FreelanceCategoryController < ApplicationController
	def index
		freelance_categories = FreelanceCategory.all

		render json: freelance_categories
	end
end
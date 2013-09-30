class FreelancerController < ApplicationController
	def index
		@freelancers = FreelancerManager.index
		render 'freelancer/index'
	end

	def create
		@freelancer = FreelancerManager.create(params[:freelancer])
		render json: {status: "success"}
	end
end
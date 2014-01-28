class FreelancerController < ApplicationController
	def create
		# POST api/1.0/freelancer/create
		@freelancer = FreelancerManager.create(params[:freelancer])
		render json: {status: "success"}
	end
end
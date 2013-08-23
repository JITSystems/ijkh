class FreelancerController < ApplicationController
	def index
		@freelancers = FreelancerManager.index
		render 'freelancer/index'
	end
end
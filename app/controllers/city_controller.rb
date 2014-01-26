class CityController < ApplicationController
	def index
	# GET api/1.0/cities
		@cities = City.index
		render 'city/index'
	end
end
class CityController < ApplicationController
	def index
		@cities = City.all
		render 'city/index'
	end

	def fill_served_cities
		
	end
end
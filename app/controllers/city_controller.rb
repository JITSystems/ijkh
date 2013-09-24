class CityController < ApplicationController
	def index
		@cities = City.all
		render 'city/index'
	end
end
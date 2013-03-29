class PlaceController < ApplicationController
	def index
		places = Place.places_index current_user
		render json: places
	end
	
	def create
		params[:place].merge!(user_id: current_user.id, is_active: true)
		place = Place.new_place params[:place]
			render json: place
	end 

	def update
		place = Place.update_place params[:place_id], params[:place]
			render json: place
	end
end
class PlaceController < ApplicationController
	def index
		#@places = Place.places_index current_user
		@places = Place.where("user_id=? and is_active = true", current_user.id)
		render 'place/index'
	end
	
	def create
		params[:place].merge!(user_id: current_user.id, is_active: true)
		@place = Place.new_place params[:place]
		render 'place/show'
	end

	def update
		@place = Place.update_place params[:place_id], params[:place]
			render 'place/show'
	end
end
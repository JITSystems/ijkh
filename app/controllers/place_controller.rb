class PlaceController < ApplicationController
	def index
		@user = User.where(authentication_token: params[:auth_token]).first
		@places = @user.places.select("id, title, city, street, building, apartment").where(is_active: true)
		render json: @places
	end

	def create
		@user = User.where(authentication_token: params[:auth_token]).first
		@place = Place.new(params[:place].merge user_id: @user.id, is_active: true)

		if @place.save
			render json: @place
		else
			render json: {error: "something went wrong"}
		end
	end 

	def update
		@user = User.where(authentication_token: params[:auth_token]).first
		@place = Place.find(params[:place_id])
      	if @place.update_attributes(params[:place])
			render json: @place
      	else
      		render json: {error: "something went wrong"}
      	end
	end
end
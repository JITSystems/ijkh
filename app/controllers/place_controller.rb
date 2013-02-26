class PlaceController < ApplicationController
	def index
		@user = User.where(authentication_token: params[:auth_token]).first
		@places = @user.places.select("id, title, city, street, building, apartment").where(is_active: true).includes(:services)
		render json: { places: @places.as_json( include: 
									{ services: 
										{ except: [:created_at, :updated_at, :user_id] }
									}
								)
							}
	end

	def create
		@user = User.where(authentication_token: params[:auth_token]).first
		@place = Place.new(params[:place].merge user_id: @user.id, is_active: true)

		if @place.save
			render json: {place: @place.as_json( except: [:created_at, :updated_at] )}
		else
			render json: {error: "something went wrong"}
		end
	end 

	def update
		@user = User.where(authentication_token: params[:auth_token]).first
		@place = Place.find(params[:id])
      	if @place.update_attributes(params[:place])
			render json: {place: @place.as_json( except: [:created_at, :updated_at] )}
      	else
      		render json: {error: "something went wrong"}
      	end
	end
end
class PlaceController < ApplicationController

  def index
    @places = PlaceManager.index_by_user(current_user)
    render 'place/index'
  end

  def create
    @place = PlaceManager.create(params[:place], current_user)
    render 'place/show'
  end

  def update
    @place = PlaceManager.update(params[:place], PlaceManager.get(params[:place_id]))
    render 'place/show'
  end

  def city_id_match
    @places = PlaceManager.index
    @places.each do |place|
      city = City.where(title: place[:city].capitalize).first
      if city
        place.update_attribute(:city_id, city.id)
      else
        place.update_attribute(:city_id, 0)
      end
    end
    render json: @places
  end
end
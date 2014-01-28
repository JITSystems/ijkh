class PlaceController < ApplicationController

  def index
    # GET api/1.0/places
    @places = PlaceManager.index_by_user(current_user)
    render 'place/index'
  end

  def create
    # POST api/1.0/place
    @place = PlaceManager.create(params[:place], current_user)
    render 'place/show'
  end

  def update
    # PUT api/1.0/place/:place_id
    @place = PlaceManager.update(params[:place], PlaceManager.get(params[:place_id]))
    render 'place/show'
  end

  def city_id_match
    # GET api/1.0/place/city_id
    @places = PlaceManager.city_id_match
    render json: @places
  end
end
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

end
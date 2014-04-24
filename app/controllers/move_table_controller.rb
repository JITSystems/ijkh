class MoveTableController < ApplicationController

  def move
    render json: MoveTable.new(params[:table]).move.to_json
  end
end

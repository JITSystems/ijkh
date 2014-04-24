class MoveTableController < ApplicationController

  def move
    data = MoveTable.new("http://192.168.0.100/users", "User").move
    render json: data
  end
end

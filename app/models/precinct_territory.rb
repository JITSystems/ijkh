class PrecinctTerritory < ActiveRecord::Base
  attr_accessible :house, :precinct_id, :street

  belongs_to :precinct
end

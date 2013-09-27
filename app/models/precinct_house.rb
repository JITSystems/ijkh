class PrecinctHouse < ActiveRecord::Base
  attr_accessible :house, :precinct_id, :street_id

  belongs_to :precinct
  belongs_to :precinct_street
end

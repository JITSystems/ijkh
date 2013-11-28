class PrecinctHouse < ActiveRecord::Base
  attr_accessible :house, :precinct_id, :precinct_street_id

  belongs_to :precinct
  belongs_to :precinct_street
end

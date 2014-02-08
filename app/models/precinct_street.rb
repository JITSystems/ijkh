class PrecinctStreet < ActiveRecord::Base
  attr_accessible :street

  has_many :precinct_houses
end

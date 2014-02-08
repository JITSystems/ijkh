class Precinct < ActiveRecord::Base
  attr_accessible :middlename, :name, :ovd, :ovd_house, :ovd_street, :ovd_telnumber, :ovd_town, :photo_url, :surname

  has_many :precinct_houses
end

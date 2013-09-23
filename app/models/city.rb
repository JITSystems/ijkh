class City < ActiveRecord::Base
  attr_accessible :title

  has_many :served_cities
  has_many :vendors, through: :served_cities


  has_many :non_utility_served_cities
  has_many :non_utility_vendors, through: :non_utility_served_cities
end

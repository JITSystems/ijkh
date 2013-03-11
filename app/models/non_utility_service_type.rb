class NonUtilityServiceType < ActiveRecord::Base
  attr_accessible :description, :title

  has_many :non_utility_vendors
end

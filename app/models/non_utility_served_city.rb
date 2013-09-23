class NonUtilityServedCity < ActiveRecord::Base
  attr_accessible :city_id, :non_utility_vendor_id

  belongs_to :non_utility_vendor
  belongs_to :city
end

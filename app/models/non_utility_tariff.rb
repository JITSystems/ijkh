class NonUtilityTariff < ActiveRecord::Base
  attr_accessible :description, :non_utility_vendor_id, :title

  belongs_to :non_utility_vendor
end

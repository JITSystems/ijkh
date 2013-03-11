class NonUtilityVendorMapPosition < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :title, :non_utility_vendor_id

  belongs_to :non_utility_vendor
end

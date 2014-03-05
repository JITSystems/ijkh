class NonUtilityVendorsContact < ActiveRecord::Base
  attr_accessible :phone, :title, :non_utility_vendor_id

  belongs_to :non_utility_vendor
end

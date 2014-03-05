class NonUtilityVendorsContact < ActiveRecord::Base
  attr_accessible :phone, :title, :vendor_id

  belongs_to :non_utility_vendor
end

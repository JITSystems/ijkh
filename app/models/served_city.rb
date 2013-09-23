class ServedCity < ActiveRecord::Base
  attr_accessible :city_id, :vendor_id

  belongs_to :vendor
  belongs_to :city
end

class EmergencyDistrict < ActiveRecord::Base
  attr_accessible :title

  has_many :emergency_services
end

class EmergencyService < ActiveRecord::Base
  attr_accessible :emergency_district_id, :title

  belongs_to :emergency_category
  has_many :emergency_infos
end

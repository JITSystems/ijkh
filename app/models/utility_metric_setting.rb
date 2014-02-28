class UtilityMetricSetting < ActiveRecord::Base
  attr_accessible :address, :energy_phase_one, :energy_phase_two, :user_id, :vendor_id, :water_cold, :water_hot

  validates :address, presence: true

  belongs_to :user
  belongs_to :vendor
end

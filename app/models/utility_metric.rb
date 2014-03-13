class UtilityMetric < ActiveRecord::Base
  attr_accessible :energy_phase_common, :energy_phase_one, :energy_phase_two, :gas, :user_id, :vendor_id, :water_cold, :water_hot, :processed


  has_one :utility_metric_setting
  
  belongs_to :user
  belongs_to :vendor
end
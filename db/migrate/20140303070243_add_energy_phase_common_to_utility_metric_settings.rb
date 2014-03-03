class AddEnergyPhaseCommonToUtilityMetricSettings < ActiveRecord::Migration
  def change
    add_column :utility_metric_settings, :energy_phase_common, :boolean
  end
end

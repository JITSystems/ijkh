class AddEnergyPhaseCommonToUtilityMetrics < ActiveRecord::Migration
  def change
    add_column :utility_metrics, :energy_phase_common, :float
  end
end

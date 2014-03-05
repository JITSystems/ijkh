class AddProcessedToUtilityMetrics < ActiveRecord::Migration
  def change
    add_column :utility_metrics, :processed, :boolean
  end
end

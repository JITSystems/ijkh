class CreateUtilityMetricSettings < ActiveRecord::Migration
  def change
    create_table :utility_metric_settings do |t|
      t.integer :user_id
      t.boolean :water_cold
      t.boolean :water_hot
      t.boolean :energy_phase_one
      t.boolean :energy_phase_two
      t.string :address
      t.integer :vendor_id

      t.timestamps
    end
  end
end

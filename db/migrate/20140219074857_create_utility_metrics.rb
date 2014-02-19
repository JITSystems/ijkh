class CreateUtilityMetrics < ActiveRecord::Migration
  def change
    create_table :utility_metrics do |t|
      t.integer :user_id
      t.integer :vendor_id
      t.float :water_hot
      t.float :water_cold
      t.float :energy_phase_one
      t.float :energy_phase_two
      t.float :gas

      t.timestamps
    end
  end
end

class CreateMeterReadings < ActiveRecord::Migration
  def change
    create_table :meter_readings do |t|
      t.integer :tariff_id
      t.integer :value_id
      t.string :reading
      t.integer :user_id

      t.timestamps
    end
  end
end

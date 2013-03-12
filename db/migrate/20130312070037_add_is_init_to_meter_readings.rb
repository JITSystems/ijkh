class AddIsInitToMeterReadings < ActiveRecord::Migration
  def change
    add_column :meter_readings, :is_init, :boolean
  end
end

class AddFieldIdToMeterReadings < ActiveRecord::Migration
  def change
    add_column :meter_readings, :field_id, :integer
  end
end

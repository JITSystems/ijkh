class AddServiceIdToMeterReadings < ActiveRecord::Migration
  def change
    add_column :meter_readings, :service_id, :integer
  end
end

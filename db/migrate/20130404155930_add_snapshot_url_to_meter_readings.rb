class AddSnapshotUrlToMeterReadings < ActiveRecord::Migration
  def change
    add_column :meter_readings, :snapshot_url, :string
  end
end

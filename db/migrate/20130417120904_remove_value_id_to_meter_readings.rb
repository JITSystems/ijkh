class RemoveValueIdToMeterReadings < ActiveRecord::Migration
  def up
  	remove_column :meter_readings, :value_id
  end

  def down
  	add_column :meter_readings, :value_id, :integer
  end
end

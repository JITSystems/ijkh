class RemoveTariffIdToMeterReadings < ActiveRecord::Migration
  def up
  	remove_column :meter_readings, :tariff_id
  end

  def down
  	add_column :meter_readings, :tariff_id, :integer
  end
end

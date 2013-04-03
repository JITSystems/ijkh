class ChangeReadingsInBills < ActiveRecord::Migration
  def up
  	change_column :meter_readings, :reading, :decimal
  end

  def down
  	change_column :meter_readings, :reading, :string
  end
end

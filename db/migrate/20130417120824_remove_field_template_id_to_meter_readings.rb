class RemoveFieldTemplateIdToMeterReadings < ActiveRecord::Migration
  def up
  	remove_column :meter_readings, :field_template_id
  end

  def down
  	add_column :meter_readings, :field_template_id, :integer
  end
end

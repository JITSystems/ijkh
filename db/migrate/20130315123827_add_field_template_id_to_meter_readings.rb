class AddFieldTemplateIdToMeterReadings < ActiveRecord::Migration
  def up
    add_column :meter_readings, :field_template_id, :integer
  end

  def down
    remove_column :meter_readings, :field_template_id
  end
end

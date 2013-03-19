class AddHasReadingsToTariffTemplates < ActiveRecord::Migration
  def up
    add_column :tariff_templates, :has_readings, :boolean
  end

  def down
    remove_column :tariff_templates, :has_readings
  end
end

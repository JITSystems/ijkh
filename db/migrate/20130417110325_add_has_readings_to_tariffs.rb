class AddHasReadingsToTariffs < ActiveRecord::Migration
  def change
    add_column :tariffs, :has_readings, :boolean
  end
end

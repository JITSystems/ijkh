class AddTariffTitleToBills < ActiveRecord::Migration
  def change
    add_column :bills, :tariff_title, :string
  end
end

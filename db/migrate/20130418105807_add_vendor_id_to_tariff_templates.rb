class AddVendorIdToTariffTemplates < ActiveRecord::Migration
  def change
    add_column :tariff_templates, :vendor_id, :integer
  end
end

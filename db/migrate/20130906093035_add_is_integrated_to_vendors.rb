class AddIsIntegratedToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :is_integrated, :boolean
  end
end

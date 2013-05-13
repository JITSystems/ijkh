class AddIsActiveToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :is_active, :boolean
  end
end

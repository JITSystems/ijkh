class AddCommissionToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :commission, :float
  end
end

class AddInnToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :inn, :string
  end
end

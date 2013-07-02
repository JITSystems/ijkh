class AddPskToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :psk, :string
  end
end

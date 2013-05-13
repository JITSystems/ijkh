class AddMerchantIdToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :merchant_id, :integer
  end
end

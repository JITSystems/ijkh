class AddVendorTitleToBills < ActiveRecord::Migration
  def change
    add_column :bills, :vendor_title, :string
  end
end

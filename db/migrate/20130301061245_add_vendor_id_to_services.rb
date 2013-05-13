class AddVendorIdToServices < ActiveRecord::Migration
  def change
    add_column :services, :vendor_id, :integer
  end

  def down
  	remove_column :services, :vendor_id
  end
end

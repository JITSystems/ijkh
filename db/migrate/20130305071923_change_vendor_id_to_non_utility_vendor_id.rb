class ChangeVendorIdToNonUtilityVendorId < ActiveRecord::Migration
  def up
  	rename_column :non_utility_vendor_map_positions, :vendor_id, :non_utility_vendor_id
  end

  def down
  	rename_column :non_utility_vendor_map_positions, :non_utility_vendor_id, :vendor_id
  end
end

class CreateNonUtilityVendorMapPositions < ActiveRecord::Migration
  def change
    create_table :non_utility_vendor_map_positions do |t|
      t.string :title
      t.string :latitude
      t.string :longitude
      t.integer :vendor_id

      t.timestamps
    end
  end
end

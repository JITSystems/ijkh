class AddPlaceIdToBills < ActiveRecord::Migration
  def up
    add_column :bills, :place_id, :integer
  end

  def down
  	remove_column :bills, :place_id
  end
end

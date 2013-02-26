class AddPlaceIdToServices < ActiveRecord::Migration
  def change
    add_column :services, :place_id, :integer
  end
end

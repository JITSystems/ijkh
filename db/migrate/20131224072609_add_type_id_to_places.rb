class AddTypeIdToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :type_id, :integer
  end
end

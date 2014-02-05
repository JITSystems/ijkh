class AddIndexToPrecinctTerritory < ActiveRecord::Migration
  def change
  	add_index :precinct_territories, :street
  end
end

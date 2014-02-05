class RenameStreetIdToPrecinctStreetId < ActiveRecord::Migration
  def change
  	rename_column :precinct_houses, :street_id, :precinct_street_id
  end
end

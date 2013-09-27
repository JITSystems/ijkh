class DropPrecinctTerritories < ActiveRecord::Migration
  def change
  	drop_table :precinct_territories
  end
end

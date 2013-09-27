class CreatePrecinctStreets < ActiveRecord::Migration
  def change
    create_table :precinct_streets do |t|
      t.string :street
    end
  end
end

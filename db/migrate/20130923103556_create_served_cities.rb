class CreateServedCities < ActiveRecord::Migration
  def change
    create_table :served_cities do |t|
      t.integer :vendor_id
      t.integer :city_id
    end
  end
end

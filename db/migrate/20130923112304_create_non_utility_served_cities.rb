class CreateNonUtilityServedCities < ActiveRecord::Migration
  def change
    create_table :non_utility_served_cities do |t|
      t.integer :non_utility_vendor_id
      t.integer :city_id
    end
  end
end

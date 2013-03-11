class CreateNonUtilityVendors < ActiveRecord::Migration
  def change
    create_table :non_utility_vendors do |t|
      t.string :title
      t.string :description
      t.string :phone
      t.string :work_time
      t.string :address
      t.integer :non_utility_service_type_id

      t.timestamps
    end
  end
end

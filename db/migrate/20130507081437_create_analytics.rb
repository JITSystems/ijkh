class CreateAnalytics < ActiveRecord::Migration
  def change
    create_table :analytics do |t|
      t.string :amount
      t.integer :place_id
      t.integer :service_id
      t.string :place_title
      t.integer :service_title
      t.string :tariff_title

      t.timestamps
    end
  end
end

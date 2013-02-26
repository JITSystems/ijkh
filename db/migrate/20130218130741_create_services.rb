class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :title
      t.integer :user_id
      t.integer :tariff_id

      t.timestamps
    end
  end
end

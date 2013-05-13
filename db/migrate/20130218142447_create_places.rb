class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.integer :user_id
      t.string :title
      t.string :city
      t.string :street
      t.string :building
      t.string :apartment
      t.boolean :is_active

      t.timestamps
    end
  end
end

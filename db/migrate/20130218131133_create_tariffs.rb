class CreateTariffs < ActiveRecord::Migration
  def change
    create_table :tariffs do |t|
      t.string :title
      t.integer :tariff_template_id
      t.integer :owner_id
      t.string :owner_type

      t.timestamps
    end
  end
end

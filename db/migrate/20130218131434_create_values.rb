class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.integer :tariff_id
      t.integer :field_template_id
      t.string :value

      t.timestamps
    end
  end
end

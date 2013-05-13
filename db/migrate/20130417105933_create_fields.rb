class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :title
      t.string :field_type
      t.boolean :is_for_calc
      t.string :value
      t.string :reading_fild_title
      t.integer :tariff_id
      t.integer :field_template_id

      t.timestamps
    end
  end
end

class CreateFieldTemplates < ActiveRecord::Migration
  def change
    create_table :field_templates do |t|
      t.string :title
      t.integer :tariff_template_id
      t.string :field_type

      t.timestamps
    end
  end
end

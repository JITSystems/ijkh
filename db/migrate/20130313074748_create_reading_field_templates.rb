class CreateReadingFieldTemplates < ActiveRecord::Migration
  def change
    create_table :reading_field_templates do |t|
      t.string :title
      t.integer :field_template_id

      t.timestamps
    end
  end
end

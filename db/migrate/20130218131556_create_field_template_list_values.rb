class CreateFieldTemplateListValues < ActiveRecord::Migration
  def change
    create_table :field_template_list_values do |t|
      t.integer :field_template_id
      t.string :value

      t.timestamps
    end
  end
end

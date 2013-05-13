class CreateFieldTemplateLists < ActiveRecord::Migration
  def change
    create_table :field_template_lists do |t|
      t.integer :field_id
      t.string :value

      t.timestamps
    end
  end
end

class AddReadingFieldTitleToFieldTemplates < ActiveRecord::Migration
  def change
    add_column :field_templates, :reading_field_title, :string
  end
end

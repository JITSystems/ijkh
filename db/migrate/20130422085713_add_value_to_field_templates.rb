class AddValueToFieldTemplates < ActiveRecord::Migration
  def change
    add_column :field_templates, :value, :string
  end
end

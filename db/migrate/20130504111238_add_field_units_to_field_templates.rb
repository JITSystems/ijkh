class AddFieldUnitsToFieldTemplates < ActiveRecord::Migration
  def change
    add_column :field_templates, :field_units, :string
  end
end

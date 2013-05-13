class ChangeFieldTemplateListsToFieldListValues < ActiveRecord::Migration
  def up
  	rename_table :field_template_lists, :field_list_values
  end

  def down
  	rename_table :field_list_values, :field_template_lists
  end
end

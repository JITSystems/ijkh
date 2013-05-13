class AddIsForCalcToFieldTemplates < ActiveRecord::Migration
  def change
    add_column :field_templates, :is_for_calc, :boolean
  end
end

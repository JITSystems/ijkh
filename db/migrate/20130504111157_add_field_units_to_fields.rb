class AddFieldUnitsToFields < ActiveRecord::Migration
  def change
  	add_column :fields, :field_units, :string
  end
end

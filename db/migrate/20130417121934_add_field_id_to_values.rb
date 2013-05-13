class AddFieldIdToValues < ActiveRecord::Migration
  def change
    add_column :values, :field_id, :integer
  end
end

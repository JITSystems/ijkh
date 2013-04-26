class AddServiceIdToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :service_id, :integer
  end
end

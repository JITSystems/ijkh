class AddAccountIdToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :account_id, :integer
  end
end

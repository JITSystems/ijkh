class ChangePrecisionInRecipes < ActiveRecord::Migration
  def up
  	 change_column :recipes, :amount, :float, :precision => 2, :scale => 2
  end

  def down
  end
end

class ChangeBillIdToRecipeIdInPaymentHistories < ActiveRecord::Migration
  def up
  	rename_column :payment_histories, :bill_id, :recipe_id
  end

  def down
  	rename_column :payment_histories, :recipe_id, :bill_id 
  end
end

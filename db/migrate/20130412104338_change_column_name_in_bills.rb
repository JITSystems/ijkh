class ChangeColumnNameInBills < ActiveRecord::Migration
  def up
  	rename_column :payment_histories, :card_namber, :card_number
  end

  def down
  	rename_column :payment_histories, :card_number, :card_namber
  end
end

class ChangeAmountInBills < ActiveRecord::Migration
  def up
  	change_column :bills, :amount, :decimal
  end

  def down
  	change_column :bills, :amount, :string
  end
end

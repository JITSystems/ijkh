class ChangeAmountInAccounts < ActiveRecord::Migration
  def up
  	remove_column :accounts, :amount
  	add_column :accounts, :amount, :float
  end

  def down
  	remove_column :accounts, :amount
  	add_column :accounts, :amount, :string
  end
end

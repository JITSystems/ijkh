class ChangeAmountTypeInBills < ActiveRecord::Migration
  def up
  	change_column :bills, :amount, :string
  end

  def down
  	change_column :bills, :amount, :decimal
  end
end

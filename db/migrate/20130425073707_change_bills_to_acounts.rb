class ChangeBillsToAcounts < ActiveRecord::Migration
  def up
  	rename_table :bills, :accounts
  end

  def down
  	rename_table :accounts, :bills
  end
end

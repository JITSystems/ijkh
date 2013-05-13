class RemoveIsPaidFromBills < ActiveRecord::Migration
  def up
    remove_column :bills, :is_paid
  end

  def down
    add_column :bills, :is_paid, :boolean
  end
end

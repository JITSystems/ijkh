class RemoveServiceIdFromBills < ActiveRecord::Migration
  def up
    remove_column :bills, :service_id
  end

  def down
    add_column :bills, :service_id, :string
  end
end

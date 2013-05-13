class AddStatusToBills < ActiveRecord::Migration
  def change
    add_column :bills, :status, :integer
  end
end

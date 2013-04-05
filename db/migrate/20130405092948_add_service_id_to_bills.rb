class AddServiceIdToBills < ActiveRecord::Migration
  def change
    add_column :bills, :service_id, :integer
  end
end

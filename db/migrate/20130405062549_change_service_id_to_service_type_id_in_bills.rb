class ChangeServiceIdToServiceTypeIdInBills < ActiveRecord::Migration
  def up
  	rename_column :bills, :service_id, :service_type_id
  end

  def down
  	rename_column :bills, :service_type_id, :service_id
  end
end

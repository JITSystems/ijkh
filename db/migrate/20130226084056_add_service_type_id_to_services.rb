class AddServiceTypeIdToServices < ActiveRecord::Migration
  def change
    add_column :services, :service_type_id, :integer
  end

  def down
  	remove_column :services, :service_type_id
  end
end

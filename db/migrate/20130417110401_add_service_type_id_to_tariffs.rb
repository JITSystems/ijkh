class AddServiceTypeIdToTariffs < ActiveRecord::Migration
  def change
    add_column :tariffs, :service_type_id, :integer
  end
end

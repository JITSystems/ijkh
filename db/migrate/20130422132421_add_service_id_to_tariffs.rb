class AddServiceIdToTariffs < ActiveRecord::Migration
  def change
    add_column :tariffs, :service_id, :integer
  end
end

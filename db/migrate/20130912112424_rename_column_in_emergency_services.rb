class RenameColumnInEmergencyServices < ActiveRecord::Migration
  def up
  	rename_column :emergency_services, :emergency_district_id, :emergency_category_id
  end

  def down
  end
end

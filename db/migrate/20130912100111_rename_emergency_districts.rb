class RenameEmergencyDistricts < ActiveRecord::Migration
def change
  	rename_table :emergency_districts, :emergency_categories
  end
end

class CreateEmergencyServices < ActiveRecord::Migration
  def change
    create_table :emergency_services do |t|
      t.string :title
      t.integer :emergency_district_id
    end
  end
end

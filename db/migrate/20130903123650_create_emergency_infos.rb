class CreateEmergencyInfos < ActiveRecord::Migration
  def change
    create_table :emergency_infos do |t|
      t.string :title
      t.string :description
      t.integer :emergency_service_id
      t.string :phone
    end
  end
end

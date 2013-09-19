class CreateEmergencyDistricts < ActiveRecord::Migration
  def change
    create_table :emergency_districts do |t|
      t.string :title
    end
  end
end

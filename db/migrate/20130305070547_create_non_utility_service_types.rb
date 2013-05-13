class CreateNonUtilityServiceTypes < ActiveRecord::Migration
  def change
    create_table :non_utility_service_types do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end

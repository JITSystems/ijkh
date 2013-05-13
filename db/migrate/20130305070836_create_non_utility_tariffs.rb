class CreateNonUtilityTariffs < ActiveRecord::Migration
  def change
    create_table :non_utility_tariffs do |t|
      t.string :title
      t.string :description
      t.integer :non_utility_vendor_id

      t.timestamps
    end
  end
end

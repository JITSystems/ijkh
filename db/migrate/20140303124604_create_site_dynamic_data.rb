class CreateSiteDynamicData < ActiveRecord::Migration
  def change
    create_table :site_dynamic_data do |t|
      t.string :house_counter

      t.timestamps
    end
  end
end

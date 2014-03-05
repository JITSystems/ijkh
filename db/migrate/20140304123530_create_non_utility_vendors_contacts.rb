class CreateNonUtilityVendorsContacts < ActiveRecord::Migration
  def change
    create_table :non_utility_vendors_contacts do |t|
      t.integer :non_utility_vendor_id
      t.string :title
      t.string :phone

      t.timestamps
    end
  end
end

class CreateFreelanceInterfaceTopTenLists < ActiveRecord::Migration
  def change
    create_table :freelance_interface_top_ten_lists do |t|
      t.integer :freelancer_id
      t.date :unpublish_at

      t.timestamps
    end
  end
end

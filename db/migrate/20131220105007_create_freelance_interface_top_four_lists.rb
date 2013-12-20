class CreateFreelanceInterfaceTopFourLists < ActiveRecord::Migration
  def change
    create_table :freelance_interface_top_four_lists do |t|
      t.integer :freelancer_id
      t.integer :tag_id
      t.date :unpublish_at

      t.timestamps
    end
  end
end

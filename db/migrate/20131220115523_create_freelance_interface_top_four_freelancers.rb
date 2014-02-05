class CreateFreelanceInterfaceTopFourFreelancers < ActiveRecord::Migration
  def change
    create_table :freelance_interface_top_four_freelancers do |t|
      t.integer :freelancer_id
      t.integer :tag_id
      t.date :unpublish_at

      t.timestamps
    end
  end
end

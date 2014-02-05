class CreateFreelanceInterfaceFreelancerTags < ActiveRecord::Migration
  def change
    create_table :freelance_interface_freelancer_tags do |t|
      t.integer :tag_id
      t.integer :freelancer_id

      t.timestamps
    end
  end
end

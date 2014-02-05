class CreateFreelanceInterfaceComments < ActiveRecord::Migration
  def change
    create_table :freelance_interface_comments do |t|
      t.text :body
      t.float :raiting
      t.boolean :published
      t.integer :freelancer_id

      t.timestamps
    end
  end
end

class CreateFreelanceInterfaceFreelancers < ActiveRecord::Migration
  def change
    create_table :freelance_interface_freelancers do |t|
      t.string :name
      t.string :surname
      t.string :phone_number
      t.string :picture_url
      t.text :description
      t.float :raiting
      t.boolean :published
      t.date :unpublish_at

      t.timestamps
    end
  end
end

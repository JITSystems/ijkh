class CreateFreelancers < ActiveRecord::Migration
  def change
    create_table :freelancers do |t|
      t.string :title
      t.string :phone
      t.string :work_time
      t.string :description
      t.string :picture_url
      t.integer :category_id

      t.timestamps
    end
  end
end

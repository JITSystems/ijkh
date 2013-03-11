class CreateFreelanceCategories < ActiveRecord::Migration
  def change
    create_table :freelance_categories do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end

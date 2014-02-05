class CreateFreelanceInterfaceTags < ActiveRecord::Migration
  def change
    create_table :freelance_interface_tags do |t|
      t.string :title
      t.float :weight
      t.boolean :published

      t.timestamps
    end
  end
end

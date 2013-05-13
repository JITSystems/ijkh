class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :user_id
      t.integer :service_id
      t.string :amount
      t.boolean :is_paid

      t.timestamps
    end
  end
end

class CreatePaymentHistories < ActiveRecord::Migration
  def change
    create_table :payment_histories do |t|
      t.integer :user_id
      t.integer :card_id
      t.string :amount

      t.timestamps
    end
  end
end

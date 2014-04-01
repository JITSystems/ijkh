class CreateTerminalPayments < ActiveRecord::Migration
  def change
    create_table :terminal_payments do |t|
      t.float :total
      t.float :amount
      t.float :commission
      t.string :user_account
      t.integer :vendor_id
      t.integer :tariff_template_id

      t.timestamps
    end
  end
end

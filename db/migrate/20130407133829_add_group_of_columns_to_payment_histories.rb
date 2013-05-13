class AddGroupOfColumnsToPaymentHistories < ActiveRecord::Migration
  def change
    add_column :payment_histories, :po_date_time, :datetime
    add_column :payment_histories, :po_transaction_id, :integer
    add_column :payment_histories, :bill_id, :integer
    add_column :payment_histories, :currency, :string
    add_column :payment_histories, :card_holder, :string
    add_column :payment_histories, :card_namber, :string
    add_column :payment_histories, :country, :string
    add_column :payment_histories, :city, :string
    add_column :payment_histories, :eci, :string
  end
end

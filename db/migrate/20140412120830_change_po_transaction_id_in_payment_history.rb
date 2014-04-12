class ChangePoTransactionIdInPaymentHistory < ActiveRecord::Migration
  def up
    change_column :payment_histories, :po_transaction_id, :string
  end

  def down
    change_column :payment_histories, :po_transaction_id, :integer
  end
end

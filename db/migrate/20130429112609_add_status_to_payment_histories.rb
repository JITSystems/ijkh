class AddStatusToPaymentHistories < ActiveRecord::Migration
  def change
    add_column :payment_histories, :status, :integer
  end
end

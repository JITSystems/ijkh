class AddTypeToPaymentHistories < ActiveRecord::Migration
  def change
    add_column :payment_histories, :type, :string
  end
end

class AddServiceIdToPaymentHistories < ActiveRecord::Migration
  def change
    add_column :payment_histories, :service_id, :integer
  end
end

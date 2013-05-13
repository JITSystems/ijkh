class ChangeTypeToPaymentTypeInPaymentHistories < ActiveRecord::Migration
  def up
  	rename_column :payment_histories, :type, :payment_type
  end

  def down
  	rename_column :payment_histories, :payment_type, :type
  end
end

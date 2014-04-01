class TerminalPayment < ActiveRecord::Base
  attr_accessible :amount, :commission, :tariff_template_id, :total, :user_account, :vendor_id
end

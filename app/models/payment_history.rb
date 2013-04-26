class PaymentHistory < ActiveRecord::Base
	scope :by_user, lambda {|current_user| where(user_id: current_user.id)}
  attr_accessible :card_id, :user_id, :po_date_time, :po_transaction_id, :account_id, :amount, :currency, :card_holder, :card_number, :country, :city, :eci

  belongs_to :user, foreign_key: :user_id
  belongs_to :card, foreign_key: :card_id
end

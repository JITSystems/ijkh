class PaymentHistory < ActiveRecord::Base
	scope :by_user, lambda {|current_user| where(user_id: current_user.id)}
  attr_accessible :amount, :card_id, :user_id

  belongs_to :user, foreign_key: :user_id
  belongs_to :card, foreign_key: :card_id
end

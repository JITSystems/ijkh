class PaymentHistory < ActiveRecord::Base
  attr_accessible :amount, :card_id, :user_id

  belongs_to :user, foreign_key: :user_id
  belongs_to :card, foreign_key: :card_id
end

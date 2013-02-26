class Card < ActiveRecord::Base
  attr_accessible :card_number, :user_id

  belongs_to :user, foreign_key: :user_id
end

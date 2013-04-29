class Card < ActiveRecord::Base
	extend CardsRepository
	
  attr_accessible :card_title, :user_id, :rebill_anchor

  belongs_to :user, foreign_key: :user_id
end

class CardManager < ObjectManager
	def self.create(card_params)
	# card_params hash:
	# 	card_title
	# 	user_id
	# 	user_id
		Card.create!(card_params) unless exist?(card_params[:card_title], card_params[:user_id])
	end

	def self.get_by_user(user)
		user.cards
	end

	protected

	def self.exist?(card_title, user_id)
		if Card.where('user_id = ? and card_title = ?', user.id, card_title).first
	end
end
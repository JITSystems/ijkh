class CardController < ApplicationController
	def index
		# GET api/1.0/cards
		@cards = CardManager.get_by_user(current_user)
		render 'card/index'
	end

	def destroy
		# DELETE api/1.0/card/:card_id
		@card = CardManager.delete(params[:card_id])
		render json: {status: "deleted"}
	end
end
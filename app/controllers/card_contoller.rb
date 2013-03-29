class CardController < ApplicationController
	def index
	end

	def create
		card = Card.new(params[:card].merge user_id: current_user.id)

		if card.save
			render json: card
		else
			render json: {error: "something went wrong"}
		end
	end

	def update
		card = Card.find(params[:card_id])
		if card.update_attributes(params[:card])
			render json: card
		else
			render json: {error: "something went wrong"}
		end
	end

	def destroy
		card = Card.find(params[:card_id])
		if card.destroy
			render json: {status: "deleted"}
		end
	end
end
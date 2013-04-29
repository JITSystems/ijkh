class CardController < ApplicationController
	def index
		@cards = Card.fetch_by_user current_user
		render 'card/index'
	end

	def create
		@card = Card.create_card current_user, params
		render json: @card
	end

	def destroy
		@card = Card.delete_card params[:card_id]
		render json: {status: "deleted"}
	end
end
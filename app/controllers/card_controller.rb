class CardController < ApplicationController
	def index
		@cards = CardManager.get_by_user(current_user)
		render 'card/index'
	end

	def create
	end

	def destroy
		@card = CardManager.delete(params[:card_id])
		render json: {status: "deleted"}
	end
end
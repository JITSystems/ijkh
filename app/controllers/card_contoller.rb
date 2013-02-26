class CardController < ApplicationController
	def index
	end

	def create
		@user = User.select(:id).where(authentication_auth: params[:auth_token]).first
		@card = Card.new(params[:card].merge user_id: @user.id)

		if @card.save
			render json: {card: @card.as_json(only: [:id, :card_number])}
		else
			render json: {error: "something went wrong"}
		end
	end

	def update
		@card = Card.find(params[:card_id])
		if @card.update_attributes(params[:card])
			render json: {card: @card.as_json(only: [:id, :card_number])}
		else
			render json: {error: "something went wrong"}
		end
	end

	def destroy
		@card = Card.find(params[:card_id])
		if @card.destroy
			render json: {status: "deleted"}
		end
	end
end
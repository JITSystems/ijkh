class UsersController < ApplicationController

	def index
		@users = User.select_all
		render json: @users
	end

end
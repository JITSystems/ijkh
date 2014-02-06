class UsersController < ApplicationController

	def index
		@users = User.select([:first_name, :email, :created_at, :sign_in_count, :phone_number, :ios_device_token, :last_sign_in_ip, :last_sign_in_at]).all
		render json: @users
	end

end
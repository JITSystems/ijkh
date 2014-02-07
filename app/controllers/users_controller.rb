class UsersController < ApplicationController

	def index
		@users = ActiveRecord::Base.connection.select_values('SELECT first_name, email, created_at, sign_in_count, phone_number, ios_device_token, last_sign_in_ip, last_sign_in_at FROM users')
		render json: @users
	end

end
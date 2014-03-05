class Admin::UsersController < AdminController

  def create
		@user = User.create!(params[:user])
		redirect_to admin_users_path
	end

	def show
	end

	def new
		@user = User.new
	end

	def destroy
		User.find(params[:id]).destroy
		redirect_to admin_users_path
	end

	def update
		User.find(params[:id]).update_attributes(params[:user])
		redirect_to admin_users_path
	end

	def edit
		@user = User.find(params[:id])
	end

	def index
		@users = User.order("created_at DESC").all
		render :index
	end

end

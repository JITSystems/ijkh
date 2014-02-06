class Admin::UsersController < AdminController

  def index
    @users = User.all
    respond_to do |format|
    	format.json {render: @users}
    end
  end

  def show
    @user = User.find(params[:id])
  end

end

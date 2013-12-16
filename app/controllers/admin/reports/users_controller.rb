class Admin::Reports::UsersController < AdminController

  def create
  	puts params[:transactions][:from]
  	redirect_to admin_reports_path
  end

end

class Admin::UploadsController < AdminController

  def index
  end

  def create
  	uploader = ImageUploader.new
  	uploader.store!(params[:uploads][:file])
  	redirect_to admin_uploads_path
  end

end

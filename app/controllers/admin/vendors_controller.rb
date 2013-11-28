class Admin::VendorsController < AdminController

  def index
    @vendors = Vendor.all
  end

  def show
    @vendor = Vendor.find(params[:id])
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
    @vendor = Vendor.find(params[:id])
    @vendor.update_attributes(params[:vendor])
    redirect_to admin_vendor_path(@vendor)
  end

  def new
    @vendor = Vendor.new
  end

  def destroy
    
  end

  def create
    @vendor = Vendor.create(params[:vendor])
    redirect_to admin_vendor_path(@vendor)
  end

end

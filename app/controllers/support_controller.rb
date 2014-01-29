# encoding: utf-8 
class SupportController < ApplicationController
	skip_before_filter :require_auth_token

  def register_ios_device
    # POST api/1.0/register_ios_device
    current_user.register_ios_device(params[:device_token])
    render json: {}
  end

  def new_vendors_notification
    # GET apns_vendor
    VendorPushNotificationsWorker.perform_async
    render json: {status: "success"}
  end

  def users_and_vendors
    # GET get_statistics
    @users = User.all.count
    @vendors = Vendor.where(is_active: true).count
    render json: {users: @users, vendors: @vendors}
  end
end

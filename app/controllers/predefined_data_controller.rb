# encoding: utf-8 
class PredefinedDataController < ApplicationController
	skip_before_filter :require_auth_token
	def index
		if current_user
			render json: {
						user: {
							auth_token: current_user.authentication_token, 
                       		email: current_user.email,
                       		first_name: current_user.first_name,
                       		phone_number: current_user.phone_number
                      			} 
                    	}
		else
			render json: {error: "Auth failed"} #dummy
		end
	end

  def register_ios_device
    current_user.register_ios_device(params[:device_token])
    render json: {}
  end
 
  def gt_check
    @uri = URI.parse("https://80.252.16.62/check/phone/2767500")
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = @ssl
    http.basic_auth 'izkh', 'FDncbv883mJ'
    get = Net::HTTP::Get.new(@uri.request_uri)
    response = http.request(get).body
    render json: response
  end 

	def apns
    PushNotificationsWorker.perform_async
    render json: {status: "success"}
	end

  def new_vendors_notification
    VendorPushNotificationsWorker.perform_async
    render json: {status: "success"}
  end

  def osmp_check
    osmp = Osmp.new(params[:user_account], DateTime.now.to_s(:number))
    resp = osmp.check
    render json: resp
  end

  def osmp_pay
    resp = Osmp.pay
    render json: resp.body
  end

  def users_and_vendors
    @users = User.all.count
    @vendors = Vendor.where(is_active: true).count
    render json: {users: @users, vendors: @vendors}
  end

  def send_custom
    CustomPushNotificationsWorker.perform_async(params[:mess])
    render json: {status: "success"}
  end
end

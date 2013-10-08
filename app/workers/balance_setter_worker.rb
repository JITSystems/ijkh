# encoding: utf-8
class BalanceSetterWorker
  include Sidekiq::Worker

  def perform(data)
   APNS.host = Settings.apns.host
   APNS.pem  = Settings.apns.pem_file
   APNS.port = Settings.apns.port.to_i

    data["payload"].each do |el|
	  services = Service.where("vendor_id = ? and user_account = ? and is_active = true", el["vendor_id"], el["user_account"])
	  services.each do |service|
	    service.account.update_attributes(amount: el["amount"].to_f, status: -1)
	    vendor_title = service.vendor.title
	    if service.user_id
    	  user = service.user
    	  #user = User.find(2)
    	  logger.info service.inspect
		  if user.ios_device_status == :active
      	    APNS.send_notification(user.ios_device_token, :alert => "Создан счет для #{vendor_title} на сумму #{el["amount"]}", :sound => 'default')
    	  else
     	    raise "iOS device is inactive"
    	  end
	  	end
      end
    end
  end
end
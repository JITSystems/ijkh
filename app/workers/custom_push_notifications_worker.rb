# encoding: utf-8
class CustomPushNotificationsWorker
	include Sidekiq::Worker

   def perform(message)
    APNS.host = Settings.apns.host
    APNS.pem  = Settings.apns.pem_file
    APNS.port = Settings.apns.port.to_i

    #text = text.encode("unicode")
    #users = User.all
    #users.each do |user|
    user = User.find(6)
      if user.ios_device_token
        apn = APNS.send_notification(user.ios_device_token, {:alert => message, :sound => 'default'})
      end
    #end
    logger.info text
  end

end
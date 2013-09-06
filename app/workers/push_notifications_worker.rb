class PushNotificationsWorker
  include Sidekiq::Worker

  def perform(text)
    APNS.host = Settings.apns.host
    APNS.pem  = Settings.apns.pem_file
    APNS.port = Settings.apns.port.to_i
    
    #users = User.all
    #users.each do |user|
    user = User.find(2)
        if user.ios_device_status == :active
            APNS.send_notification(user.ios_device_token, :alert => text, :sound => 'default')
        else
            raise "iOS device is inactive"
        end
    #end
  end

end
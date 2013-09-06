class PushNotificationsWorker
  include Sidekiq::Worker

  def perform
    APNS.host = Settings.apns.host
    APNS.pem  = Settings.apns.pem_file
    APNS.port = Settings.apns.port.to_i
    
    #users = User.all
    #users.each do |user|
    user = User.find(1)
        if user.ios_device_token
            APNS.send_notification(user.ios_device_token, :alert => 'test', :sound => 'default')
        end
    #end
  end

end
# encoding: utf-8
class PushNotificationsWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform
    APNS.host = Settings.apns.host
    APNS.pem  = Settings.apns.pem_file
    APNS.port = Settings.apns.port.to_i
    text = 'Оплата временно недоступна. И недоступна. И недоступна опять. недоступна, недоступна, недоступна, недоступна.'
    #text = text.encode("unicode")
    #users = User.all
    #users.each do |user|
    user = User.find(2)
      if user.ios_device_token
        apn = APNS.send_notification(user.ios_device_token, {:alert => text, :sound => 'default'})
      end
    #end
    logger.info text
  end

end
# encoding: utf-8
class PushNotificationsWorker
  include Sidekiq::Worker

  def perform
    APNS.host = Settings.apns.host
    APNS.pem  = Settings.apns.pem_file
    APNS.port = Settings.apns.port.to_i
    text = 'Что то длиннее чем 80 символов, должно приходить! Пора бы!'
    text = text.force_encode("UTF-8")
    #users = User.all
    #users.each do |user|
    user = User.find(2)
      if user.ios_device_token
        APNS.send_notification(user.ios_device_token, :alert => text, :sound => 'default')
      end
    #end
  end

end
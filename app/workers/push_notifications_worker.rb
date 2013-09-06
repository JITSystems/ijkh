# encoding: utf-8
class PushNotificationsWorker
  include Sidekiq::Worker

  def perform
    APNS.host = Settings.apns.host
    APNS.pem  = Settings.apns.pem_file
    APNS.port = Settings.apns.port.to_i
    
    #users = User.all
    #users.each do |user|
     text = "В связи с техническими работами временно недоступна оплата через мобильное приложение 'АйЖКХ'. Оплату услуг Вы можете осуществить на сайте сервиса izkh.ru. Приносим извинения за неудобства."
    user = User.find(2)
        if user.ios_device_token
            APNS.send_notification(user.ios_device_token, :alert => text, :sound => 'default')
        end
    user = User.find(1)
        if user.ios_device_token
            APNS.send_notification(user.ios_device_token, :alert => text, :sound => 'default')
        end
    #end
  end

end
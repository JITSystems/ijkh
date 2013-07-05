class PushNotificationsWorker
  include Sidekiq::Worker

  def self.test
    APNS.host = Settings.apns.host
    APNS.pem  = Settings.apns.pem_file
    APNS.port = Settings.apns.port.to_i

    device_token = 'ed582741 0ba963a1 72666ec2 2dc94ae1 69e1d184 deff5b9b f45214a2 d877833d'
    APNS.send_notification(device_token, :alert => "Zaplati!", :sound => 'default')
  end

  def perform(payload)
    APNS.host = Settings.apns.host
    APNS.pem  = Settings.apns.pem_file
    APNS.port = Settings.apns.port.to_i

    users = User.accounts.where("amount > 0.0")
    users.each do |user|
      if user.ios_device_status == :active
        puts APNS.send_notification(
          user.ios_device_token,
          payload.deep_symbolize_keys
        )
      else
        raise "iOS device is inactive for character #{character.id}."
      end
    end
  end

end
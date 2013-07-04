class PushNotificationsWorker
  include Sidekiq::Worker

  def perform(user_id, payload)
    APNS.host = Settings.apns.host
    APNS.pem  = Settings.apns.pem_file
    APNS.port = Settings.apns.port.to_i

    user = User.find user_id

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
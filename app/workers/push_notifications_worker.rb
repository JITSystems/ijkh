class PushNotificationsWorker
  include Sidekiq::Worker

  def perform(payload=nil)
    # APNS.host = Settings.apns.host
    # APNS.pem  = Settings.apns.pem_file
    # APNS.port = Settings.apns.port.to_i

    # users = User.accounts.where("amount > 0.0")
    # users.each do |user|
    #   if user.ios_device_status == :active
    #     puts APNS.send_notification(
    #       user.ios_device_token,
    #       payload.deep_symbolize_keys
    #     )
    #   else
    #     raise "iOS device is inactive for character #{character.id}."
    #   end
    # end
  end

end
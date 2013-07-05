class PaymentReminder
  def send_reminder(device_token)
  	payload = {

  	}
  end

  def self.test
  	APNS.host = Settings.apns.host
    APNS.pem  = Settings.apns.pem_file
    APNS.port = Settings.apns.port.to_i

    device_token = 'ed582741 0ba963a1 72666ec2 2dc94ae1 69e1d184 deff5b9b f45214a2 d877833d'
    APNS.send_notification(device_token, :alert => "Zaplati!", :sound => 'default')
  end
end
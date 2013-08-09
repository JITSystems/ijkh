class PaymentReminder
  def send_reminder(device_token)
  	payload = {

  	}
  end

  def self.test
  	PushNotificationsWorker.perform_async
  end
end
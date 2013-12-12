# encoding: utf-8
class RegistrationNotificationWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(first_name, email, phone)
    @message = RegistrationMessage.new(subject: "Новый пользователь", first_name: first_name, email: email, phone: phone)
    PaymentMailer.new_message(@message).deliver
  end
end
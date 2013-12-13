# encoding: utf-8
class RegistrationNotificationWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(first_name, email, phone_number)
    @message = RegistrationMessage.new(subject: "Новый пользователь", first_name: first_name, email: email, phone_number: phone_number)
    RegistrationMailer.new_message(@message).deliver
  end
end
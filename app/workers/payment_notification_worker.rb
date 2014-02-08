# encoding: utf-8
class PaymentNotificationWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(first_name, email, vendor_title, amount, date)
    @message = PaymentMessage.new(subject: "Новый платеж", name: first_name, email: email, vendor: vendor_title, amount: amount, date: date)
    PaymentMailer.new_message(@message).deliver
  end
end
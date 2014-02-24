#encoding: utf-8
class NotificationsSuccessfulPaymentWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false
  
    def perform(summa, recipient, account, name, email)
    	UserNotifications.successful_payment(summa, recipient, account, name, email)
    end
end
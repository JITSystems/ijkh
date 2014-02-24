#encoding: utf-8
class NotificationsNoPaymentWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false
  
    def perform
    	User.select {|u| u.created_at.to_date == 31.days.ago.to_date}.each {|u| UserNotifications.no_payment(u.first_name, u.email) if PaymentHistory.where("user_id = ? AND created_at > ? AND status = 1", u.id, 31.days.ago).empty?} 
    	User.select {|u| u.created_at.to_date == 14.days.ago.to_date}.each {|u| UserNotifications.no_payment(u.first_name, u.email) if PaymentHistory.where("user_id = ? AND created_at > ? AND status = 1", u.id, 14.days.ago).empty?}
    end
end

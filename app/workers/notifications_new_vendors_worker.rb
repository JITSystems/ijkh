#encoding: utf-8
class NotificationsNewVendorsWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false
  
    def perform
    	User.all.each {|u| UserNotifications.new_vendors(u.first_name, u.email)} if Vendor.where("created_at > ?", 31.days.ago) != []
    end
end

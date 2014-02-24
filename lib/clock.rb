require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)

require 'clockwork'
require 'sidekiq'
 
module Clockwork
	
  	every(1.day, 'Notification no payment', :at => '00:00') { NotificationsNoPaymentWorker.perform_async }

	every(1.day, 'Notification new vendors', :at => '00:00', :if => lambda { |t| t.day == 1 }) { NotificationsNewVendorsWorker.perform_async }
  
end

require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)

require 'clockwork'
require 'sidekiq'
 
module Clockwork
  every(30.seconds, 'payment.job'){
    PushNotificationsWorker.perform_async 
  }
end

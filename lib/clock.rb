require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

every(2.days, 'payment_reminder.job', at: '19:00') { PaymentReminder.test }
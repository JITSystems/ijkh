require 'clockwork'
include Clockwork

handler do |job|
  puts "Running #{job}"
  device_token = 'ed582741 0ba963a1 72666ec2 2dc94ae1 69e1d184 deff5b9b f45214a2 d877833d'
  APNS.send_notification(device_token, :alert => "Priveeeet!", :sound => 'default')
end

every(20.seconds, 'zatrahat_dimu.job')
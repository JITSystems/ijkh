require 'faye'
Faye::WebSocket.load_adapter('thin')

faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)

Faye::Logging.log_level = :info
Faye.logger = lambda { |m| puts m }

run faye_server

# encoding: utf-8
class TdsWorker
	include Sidekiq::Worker

	def perform(url, data, auth_token)
		require 'net/http'

		ext_req = ExternalRequest.new(url, true, data)
		response = Crack::XML.parse(ext_req.post)
	
		client = Faye::Client.new('http://izkh.ru:9292/faye')
		client.publish("/server/#{auth_token}", TdsResponseManager.publish_message(response))
	end

end
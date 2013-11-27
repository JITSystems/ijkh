# encoding: utf-8
class TdsAuthWorker
	include Sidekiq::Worker

	def perform(url, data, auth_token)
		require 'net/http'

		publish_message = {}

		ext_req = ExternalRequest.new(url, true, data)
		response = Crack::XML.parse(ext_req.post)
		
		if response["transaction"]["result"].downcase == "ok"
			publish_message = {result: "success", message: I18n.t('payonline.payment_success')}
		else
			publish_message = {result: "failure", message: I18n.t('payonline.secure.failure')}
		end

		client = Faye::Client.new('http://izkh.ru:9292/faye')
		client.publish("/server/#{auth_token}", publish_message)
	end

end
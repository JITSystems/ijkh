# encoding: utf-8
class TdsAuthWorker
	include Sidekiq::Worker

	def perform(url, data, auth_token)
		require 'net/http'

		publish_message = {}
		uri = URI.parse(url)
		https = Net::HTTP.new(uri.host, uri.port)
		https.use_ssl = true
		post = Net::HTTP::Post.new(uri.path)
		post.body = data
		response = https.request(post)
		response = Crack::XML.parse(response.body)
		if response["transaction"]["result"] == "Ok"
			publish_message = {result: "success", message: "Платеж был успешно проведен. Данные поступили в обработку."}
		else
			publish_message = {result: "failure", message: "При проведении платежа произошла ошибка."}
		end

		client = Faye::Client.new('https://izkh.ru:9292/faye')
		client.publish("/server/#{auth_token}", publish_message)
	end

end
# encoding: utf-8
class EnergosbytWorker
	include Sidekiq::Worker

	def perform(url, data)

		require 'net/http'

		publish_message = {}
		uri = URI.parse(url)
		https = Net::HTTP.new(uri.host, uri.port)
		https.use_ssl = true
		post = Net::HTTP::Post.new(uri.path)
		post.body = data
		response = https.request(post)
		response = Crack::XML.parse(response.body)
		if response["transaction"]["result"].downcase == "ok"
			publish_message = {result: "success", message: "Успех."}
		else
			publish_message = {result: "failure", message: "Неудача."}
		end

	end

end
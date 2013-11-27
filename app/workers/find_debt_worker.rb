# encoding: utf-8
class FindDebtWorker
	include Sidekiq::Worker

	def perform(url, data)

		require 'net/http'

		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		post = Net::HTTP::Post.new(uri.path)
		post.body = data
		response = http.request(post)

	end

end
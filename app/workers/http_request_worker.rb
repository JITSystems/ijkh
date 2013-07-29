class HttpRequestWorker
	include Sidekiq::Worker

	def perform(url, data)
		require 'net/http'
		uri = URI.parse(po_root_url)
		https = Net::HTTP.new(uri.host, uri.port)
		https.use_ssl = true
		post = Net::HTTP::Post.new(uri.path)
		post.body = data
		response = https.request(post)
		response = Crack::XML.parse(response.body)
		client = Faye::Client.new('http://ec2-54-245-202-30.us-west-2.compute.amazonaws.com:9292/faye')
		client.publish("/server/#{params[:auth_token]}", response)
	end
end
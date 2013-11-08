class ExternalRequest
	require 'net/http'
	require 'net/https'

	def initialize(url, ssl=false, data=nil, cert_name=nil)
		@uri = URI.parse(url)
		@ssl = ssl
		@data = data if data
		@cert_name = cert_name if cert_name
	end

	def get
		http = Net::HTTP.new(@uri.host, @uri.port)
		http.use_ssl = @ssl
		if @cert_name
			http.cert = OpenSSL::X509::Certificate.new(File.read("#{@cert_name}.pem"))
			http.key = OpenSSL::PKey::RSA.new(File.read("#{@cert_name}.key"))
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		end
		get = Net::HTTP::Get.new(@uri.request_uri)
		response = http.request(get).body
	end

	def post
		http = Net::HTTP.new(@uri.host, @uri.port)
		http.use_ssl = @ssl
		if @cert_name
			http.cert = OpenSSL::X509::Certificate.new(File.read("#{@cert_name}.pem"))
			http.key = OpenSSL::PKey::RSA.new("#{@cert_name}.key")
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		end

		post = Net::HTTP::Post.new(@uri.path)
		post.body = @data
		response = http.request(post).body
	end
end

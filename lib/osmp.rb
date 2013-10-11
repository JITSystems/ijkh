class Osmp
	def self.check
	uri = URI.parse("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/3?command=check&txn_id=11441119&account=2%230034586&txn_date=20130905112330&sum=10.45")

	require "net/https"
	require "uri"
	
	pem = File.read("ijkh.pem")
	key = File.read("ijkh.key")
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	http.cert = OpenSSL::X509::Certificate.new(pem)
	http.key = OpenSSL::PKey::RSA.new(key)
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	request = Net::HTTP::Get.new(uri.request_uri)
	
	response = http.request(Net::HTTP::Get.new(uri.request_uri))
  	response
	end
end
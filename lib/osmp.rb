class Osmp
	def self.check
		uri = URI.parse("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=check&txn_id=11441119&account=2%230034586&txn_date=20130905112330&sum=10.45")
		Net::HTTP.start(uri.host, uri.port,
  		:use_ssl => uri.scheme == 'https') do |http|
  		http.cert = OpenSSL::X509::Certificate.new(File.read("ijkh.pem"))
  		request = Net::HTTP::Get.new uri
  		response = http.request(request)
	end
  		response
	end
end
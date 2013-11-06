class Osmp
	def self.check
	uri = URI.parse("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=check&txn_id=11441119&account=2%230000015&txn_date=20120827123230&sum=10.45")

	require "net/https"
	require "uri"
	
	pem = File.read("www_izkh_ru.pem")
	key = File.read("www_izkh_ru.key")
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	http.cert = OpenSSL::X509::Certificate.new(pem)
	http.key = OpenSSL::PKey::RSA.new(key)
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	request = Net::HTTP::Get.new(uri.request_uri)
	
	response = http.request(Net::HTTP::Get.new(uri.request_uri))
  	response
	end

	def self.pay
	uri = URI.parse("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=pay&txn_id=211119&account=2%23000002&txn_date=20120827112930&sum=10.45")

	require "net/https"
	require "uri"
	
	pem = File.read("www_izkh_ru.pem")
	key = File.read("www_izkh_ru.key")
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
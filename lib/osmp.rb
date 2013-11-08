class Osmp
	def self.check(user_account, date)
		user_account = user_account.to_s
		unless user_account.to_s.length >= 7
			(7 - user_account.to_s.length).times { user_account.insert(0, '0') }
			end

	uri = URI.parse("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=check&txn_id=11441119&account=2%23#{user_account}&txn_date=#{date}&sum=1.00")

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
  	response = Crack::XML.parse(response.body)
  	if response["response"]["account_balance"]
  		return response["response"]["account_balance"]
  	else
  		return nil	
  	end
	end

	def self.pay(user_account, date, amount)
	uri = URI.parse("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=pay&txn_id=211119&account=2%23#{user_account}&txn_date=#{date}&sum=#{amount}")

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
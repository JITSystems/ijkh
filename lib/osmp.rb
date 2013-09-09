class Osmp
	def self.check
	uri = URI.parse("https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=check&txn_id=11441119&account=2%230034586&txn_date=20130905112330&sum=10.45")

	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_PEER

	store = OpenSSL::X509::Store.new
	store.set_default_paths # Optional method that will auto-include the system CAs.
	store.add_cert(OpenSSL::X509::Certificate.new(File.read("ijkh.pem")))
	store.add_cert(OpenSSL::X509::Certificate.new(File.read("bgbilling.pem")))
	http.cert_store = store

	response = http.request(Net::HTTP::Get.new(uri.path))

  	response
	end
end
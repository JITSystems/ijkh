class PayOnlinePayment
	def initialize		
	end


	def pay
	end
	
	def get_private_key(service_id)
		Service.find(service_id).vendor.psk
	end

	def get_public_key(security_key_string)
		Digest::MD5.hexdigest(security_key_string)
	end
end
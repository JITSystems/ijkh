class GlobalTelecom
	def initialize(user_account, amount=nil)
		@user_account = format_user_account(user_account)
		@date = date
		@amount = amount
		if amount
			@url = "https://80.252.16.62/"
			
		else
			@url = "https://80.252.16.62/"
		end
	end

	def check
  		er = ExternalRequest.new(@url, true, nil, "www_izkh_ru")
	  	get_response(er.get)
	end

	def pay
		er = ExternalRequest.new(@url, true, nil, "www_izkh_ru")
  		er.get
	end
end
class GlobalTelecom
	def initialize(user_account, amount=nil)
		@user_account = format_user_account(user_account)
		@date = date
		@amount = amount
		if amount
			@url = "https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=pay&txn_id=211119&account=2%23#{@user_account}&txn_date=#{@date}&sum=#{@amount}"
		else
			@url = "https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=check&txn_id=11441119&account=2%23#{@user_account}&txn_date=#{@date}&sum=1.00"
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
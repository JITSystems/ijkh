class Osmp
	def initialize(user_account, date, prefix="2", amount=nil)
		@user_account = format_user_account(user_account)
		@date = date
		@amount = amount
		@prefix = prefix
		if amount
			@url = "https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=pay&txn_id=211119&account=#{@prefix}%23#{@user_account}&txn_date=#{@date}&sum=#{@amount}"
		else
			@url = "https://193.33.144.3:65443/bgbilling/mpsexecuter/13/5?command=check&txn_id=11441119&account=#{@prefix}%23#{@user_account}&txn_date=#{@date}&sum=1.00"
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

protected
	
	def format_user_account(user_account)
		user_account = user_account.to_s
		unless user_account.length >= 7
			(7 - user_account.length).times { user_account.insert(0, '0') }
		end
		return user_account
	end

	def get_response(response)
		response = Crack::XML.parse(response)
		if response["response"]["account_balance"]
	  		return response["response"]["account_balance"]
	  	else
	  		return nil
	  	end
	end

end
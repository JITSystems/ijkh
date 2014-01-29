class CraftS
	require 'uri'
	def initialize(user_account, date, amount=nil, order_id=nil)
		@user_account = user_account
		@date = date
		@amount = amount
		@order_id = order_id
		@url = "https://billing.kraft-s.ru:47035/pays/izkh.php"
	end

	def check
		url = form_check_url
  		er = ExternalRequest.new(URI.escape(url), true, nil, "izkh")
	  	er.get
	end

	def pay
		url = form_pay_url
		er = ExternalRequest.new(URI.escape(url), true, nil, "izkh")
  		er.get
	end

protected

	def form_check_url
		"#{@url}?ID=#{DateTime.now.to_s(:number)}&DATE=#{@date}&TYPE=4&ATYPE=inet&ACCOUNT=#{@user_account.to_s}&SUM=0"
	end

	def form_pay_url
		"#{@url}?ID=#{@order_id}&DATE=#{@date}&TYPE=1&ACCOUNT=#{@user_account.to_s}&ATYPE=inet&SUM=#{@amount.to_s}"
	end
	
	def get_response(response)
	end

end
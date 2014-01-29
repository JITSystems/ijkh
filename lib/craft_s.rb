# encoding: utf-8
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
	  	get_response(er.get)
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
		response = Crack::XML.parse(response)
		if response["response"]["status"].to_s == "0"
			account_type = response["response"]["atype"] == "inet" ? "Интернет" : "Телефония"
			{user_account: response["response"]["account"], 
				account_type: account_type, 
				fio: response["response"]["fio"], 
				debt: response["response"]["debt"], 
				hot_debt: response["response"]["hot_debt"]}
		else
			nil
		end
	end

end
class SamaraLan
	def initialize(number, amount=nil, order_id=nil)
		@root_url = "https://psys.samaralan.ru:8081/"
		@number = number.to_s
		@amount = amount.to_s
		@order_id = order_id.to_s
	end

	def check
		er = ExternalRequest.new(check_url, true)
		get_response(er.get)
	end

	def pay
		er_check = ExternalRequest.new(check_url, true)
		id = get_response(er_check.get)
		if id
			er_pay = ExternalRequest.new(pay_url(id.to_s), true)
			response = get_response(er_pay.get)
		else
			nil
		end
	end

protected
	
	def check_url
		url = "ok_pay_step1?agreement_number$i=#{@number}&agreement_type$i=42&cash_type$i=1"
		"#{@root_url}#{url}"
	end

	def pay_url(id)
		url = "ok_pay_step2?agreement_id$i=#{id}&value$n=#{@amount}&pay_date$c=#{Time.now.strftime("%d.%m.%Y")}&pay_num$i=#{@order_id}"
		"#{@root_url}#{url}"
	end

	def get_response(response)
		response = Crack::XML.parse(response)
		if response["ok_pay_step1"]
			if response["client_info"]
				response["ok_pay_step1"]["client_info"]["agreement_id"]
			else
				"1 part fuuu"
			end
		elsif response["ok_pay_step2"]
			response
		else
			"2 part fu"
		end
	end
end
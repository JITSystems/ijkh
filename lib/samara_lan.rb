class SamaraLan
	def initialize(type, number, amount=nil, order_id=nil)
		@root_url = "https://psys.samaralan.ru:8081/"
		@type = type
		@number = number
	end

	def check
		er = ExternalRequest.new(check_url, true)
		get_response(er.get)
	end

	def pay
		er_check = ExternalRequest.new(check_url, true)
		id = get_response(er_check.get)[:id]
		er_pay = ExternalRequest.new(pay_url(id), true)
		get_response(er_pay.get)
	end

protected
	
	def check_url
		case @type
		when 42
			url = "payments_remote_support.ok_pay_step1?agreement_number$i=#{number}&agreement_type$i=42&cash_type$i=1"
		when 6
			url = "payments_remote_support.ok_pay_step1?agreement_number$i=#{number}&agreement_type$i=6&cash_type$i=1"
		end
		"#{@root_url}#{url}"
	end

	def pay_url(id)
		url = "payments_remote_support.ok_pay_step2?agreement_id$i=#{id}&value$n=#{@amount}&pay_date$c=#{Date.now}&pay_num$i=#{@order_id}"
	end

	def get_response(response)
		response = Crack::XML.parse(response)
		puts response
	end

end
# encoding: utf-8
class GlobalTelecom
	def initialize(user_account, recipe_id=nil, amount=nil)
		@type = nil
		@user_account = user_account
		@amount = amount
		@check_url = form_check_url
		@payment_url = nil
		@recipe_id = recipe_id
	end

	def check
		if @check_url
  			er = ExternalRequest.new(@сheck_url, true)
	  		get_response(er.get_basic_auth)
	  	else 
	  		nil
	  	end
	end

	def pay
		if @check_url
			er = ExternalRequest.new(@check_url, true)
  			response = get_response(er.get_basic_auth)
  		else
  			response = nil
  		end

  		if response
  			@payment_url = form_payment_url(response["contract"]["id"], @recipe_id)
  			if @payment_url
  				er = ExternalRequest.new(@payment_url, true)
  				get_response(er.get_basic_auth)
  			else
  				nil
  			end
  		else 
  			nil
  		end
	end

protected
	def form_check_url
		url = "https://80.252.16.62/check/"
		case @user_account[0..2].mb_chars.downcase.to_s
		when "пдф"
			@user_account = @user_account[4..@user_account.length + 1].gsub!('/', '-')
			url += "inet/#{@user_account}"
			@type = :inet
		when "всф"
			@user_account = @user_account[4..@user_account.length + 1].gsub!('/', '-')
			url += "packet/#{@user_account}"
			@type = :packet
		when "твф"
			@user_account = @user_account[4..@user_account.length + 1].gsub!('/', '-')
			url += "tv/#{@user_account}"
			@type = :tv
		else
			if @user_account =~ /\d{7}/ 
				url += "phone/#{@user_account}"
				@type = :phone
			else
				url = nil
				@type = nil
			end
		end
		url
	end

	def form_payment_url(cid, tid)
		url = "https://80.252.16.62/payment/#{cid}/#{tid}/#{@amount}/"
		case @type
		when :inet
			url += '5'
		when :tv
			url += '6'
		when :phone
			url += '2'
		when :packet
			url += '9'
		else
			url = nil
		end
		url
	end

	def get_response(response)
		response = Crack::XML.parse(response)
		if response["data"]["contract"]
	  		return response["data"]["contract"]["balance"]
	  	elsif response["data"]["payments"]
	  		return response["data"]["payments"]
	  	else
	  		return nil
	  	end
	end

end
class DebtManager

	def initialize(vendor_id, user_account, current_user_id, remote_ip)
    	@vendor_id = vendor_id.to_i
    	@user_account = user_account
    	@current_user_id = current_user_id
    	@remote_ip = remote_ip
  	end
	
	def check_debt
		case @vendor_id
			when 1
				info = energosbyt
			when 16
				info = osmp
		end

		return info
	end

protected 

	def energosbyt
		info = HTTParty.get('http://cabinet.izkh.ru/energosbyt', :query => { :user_account => @user_account } )
		 # @info = HTTParty.get('http://192.168.0.73:8080/energosbyt', :query => { :user_account => params[:user_account]} )
		user_data = "user_account=#{@user_account}&user_id=#{@current_user_id}&remote_ip=#{@remote_ip}"
		FindDebtWorker.perform_async('http://cabinet.izkh.ru/energosbyt', user_data)
		# FindDebtWorker.perform_async('http://192.168.0.73:8080/energosbyt', user_data)
		data = info.parsed_response
		p data["user_account"]
		p data["invoice_amount"]
		p data["city"]
		p data["street"]



		info
	end

	def osmp
		info = Osmp.new(@user_account, DateTime.now.to_s(:number))
		amount = info.check

		p amount

		amount
	end

end
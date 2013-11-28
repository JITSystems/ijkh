# encoding: utf-8

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
		user_data = "user_account=#{@user_account}&user_id=#{@current_user_id}&remote_ip=#{@remote_ip}"
		FindDebtWorker.perform_async('http://cabinet.izkh.ru/energosbyt', user_data)
		info 
	end

	def osmp
		info = Osmp.new(@user_account, DateTime.now.to_s(:number))
		amount = info.check
		amount
	end

end
# encoding: utf-8

class LiveBalanceManager

	def initialize(vendor_id, user_account)
    	@vendor_id = vendor_id.to_i
    	@user_account = user_account
  	end
	
	def check_balance
		case @vendor_id
			when 121
				info = global_telecom
			when 900
				info = craft_s
			else 
				info = nil
		end

		return info
	end

protected 

	def global_telecom
		info = GlobalTelecom.new(@user_account).check.to_json
		info 
	end

	def craft_s
		date = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
		info = CraftS.new(@user_account, date)
		info
	end

end
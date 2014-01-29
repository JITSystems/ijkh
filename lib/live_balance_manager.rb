# encoding: utf-8

class LiveBalanceManager

	def initialize(vendor_id, user_account, tariff_template_id)
    	@vendor_id = vendor_id.to_i
    	@user_account = user_account
    	@t_t_id = tariff_template_id
  	end
	
	def check_balance
		case @vendor_id
			when 121
				info = global_telecom
			when 165
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

		account_type = nil

		case @t_t_id
			when 158
				account_type = 'voip'
			when 153
				account_type = 'inet'
		end

		date = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
		info = CraftS.new(@user_account, date, account_type)
		info
	end

end
class PayOnlineResponseManager
	def self.publish_message(response)
		if response["transaction"]
			case response["transaction"]["operation"].downcase
			when "auth"
				case response["transaction"]["result"].downcase
				when "error"
					case response["transaction"]["errorCode"]
					when "1"
						{result: "failure", message: I18n.t('payonline.non_secure.auth.error.one')}
					when "2"
						{result: "failure", message: I18n.t('payonline.non_secure.auth.error.two')}
					when "3"
						{result: "failure", message: I18n.t('payonline.non_secure.auth.error.three')}
					when "4"
						if response["transaction"]["code"] == "6001"
							md = "#{response['transaction']['id']};#{response['transaction']['threedSecure']['pd']}"
							{result: "3ds", ascurl: "#{response['transaction']['threedSecure']['acsurl']}", pareq: "#{response['transaction']['threedSecure']['pareq']}", md: md, termurl: "https://izkh.ru/api/1.0/payment/secure_callback"}
						end
					else
						{result: "failure", message: I18n.t('payonline.non_secure.unknown_error')}
					end
				when "ok" 
					{result: "success", message: I18n.t('payonline.non_secure.success')}
				end
			when "rebill"
				if response["transaction"]["result"].downcase == "error"
					case response["transaction"]["errorCode"]
					when "1"
						{result: "failure", message: I18n.t('payonline.non_secure.rebill.error.one')}
					when "2"
						{result: "failure", message: I18n.t('payonline.non_secure.rebill.error.two')}
					when "3"
						{result: "failure", message: I18n.t('payonline.non_secure.rebill.error.three')}
					when "4"
						if response["transaction"]["code"] == "6001"
							{result: "failure", message: "Операция временно недоступна"}
						end
					else
						{result: "failure", message: I18n.t('payonline.non_secure.unknown_error')}
					end
				else
					{result: "success", message: I18n.t('payonline.payment_success')}
				end
			end
		elsif response["error"]
			{result: "failure", message: "При выполнении платежа возникла ошибка: Номер ошибки - #{response['error']['code']}, Сообщение - #{response['error']['message']}"}
		else
			{result: "failure", message: I18n.t('payonline.non_secure.unknown_response')}
		end

	end
end
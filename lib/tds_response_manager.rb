# encoding: utf-8
class TdsResponseManager

	def self.publish_message(response)
		if response["transaction"]["result"].downcase == "ok"
			{result: "success", message: I18n.t('payonline.payment_success')}
		else
			{result: "failure", message: I18n.t('payonline.secure.failure')}
		end
	end

end
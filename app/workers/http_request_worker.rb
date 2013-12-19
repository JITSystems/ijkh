# encoding: utf-8
class HttpRequestWorker
	include Sidekiq::Worker

	def perform(url, data, auth_token)
		require 'net/http'

		publish_message = {}
		
		ext_req = ExternalRequest.new(url, true, data)
		response = Crack::XML.parse(ext_req.post)


		if response["transaction"]
			case response["transaction"]["operation"].downcase
			when "auth"
				case response["transaction"]["result"].downcase
				when "error"
					case response["transaction"]["errorCode"]
					when "1"
						publish_message = {result: "failure", message: I18n.t('payonline.non_secure.auth.error.one')}
					when "2"
						publish_message = {result: "failure", message: I18n.t('payonline.non_secure.auth.error.two')}
					when "3"
						publish_message = {result: "failure", message: I18n.t('payonline.non_secure.auth.error.three')}
					when "4"
						if response["transaction"]["code"] == "6001"
							md = "#{response['transaction']['id']};#{response['transaction']['threedSecure']['pd']}"
							publish_message = {result: "3ds", ascurl: "#{response['transaction']['threedSecure']['acsurl']}", pareq: "#{response['transaction']['threedSecure']['pareq']}", md: md, termurl: "https://izkh.ru/api/1.0/payment/secure_callback"}
						end
					else
						publish_message = {result: "failure", message: I18n.t('payonline.non_secure.unknown_error')}
					end
				when "ok" 
					publish_message = {result: "success", message: I18n.t('payonline.non_secure.success')}
				end
			when "rebill"
				if response["transaction"]["result"].downcase == "error"
					case response["transaction"]["errorCode"]
					when "1"
						publish_message = {result: "failure", message: I18n.t('payonline.non_secure.rebill.error.one')}
					when "2"
						publish_message = {result: "failure", message: I18n.t('payonline.non_secure.rebill.error.two')}
					when "3"
						publish_message = {result: "failure", message: I18n.t('payonline.non_secure.rebill.error.three')}
					when "4"
						if response["transaction"]["code"] == "6001"
							publish_message = {result: "failure", message: "Операция временно недоступна"}
						end
					else
						publish_message = {result: "failure", message: I18n.t('payonline.non_secure.unknown_error')}
					end
				else
					publish_message = {result: "success", message: I18n.t('payonline.payment_success')}
				end
			end
		elsif response["error"]
			publish_message = {result: "failure", message: "При выполнении платежа возникла ошибка: Номер ошибки - #{response['error']['code']}, Сообщение - #{response['error']['message']}"}
		else
			publish_message = {result: "failure", message: I18n.t('payonline.non_secure.unknown_response')}
		end

		client = Faye::Client.new('http://izkh.ru:9292/faye')
		client.publish("/server/#{auth_token}", publish_message)
	end
end
# encoding: utf-8
class HttpRequestWorker
	include Sidekiq::Worker

	def perform(url, data, auth_token)
		require 'net/http'
		publish_message = {}
		uri = URI.parse(url)
		https = Net::HTTP.new(uri.host, uri.port)
		https.use_ssl = true
		post = Net::HTTP::Post.new(uri.path)
		post.body = data
		response = https.request(post)
		response = Crack::XML.parse(response.body)
		if response["error"]
			publish_message = {result: "failure", message: "При выполнении платежа возникла ошибка: Номер ошибки - #{response['error']['code']}, Сообщение - #{response['error']['message']}"}
		else 
			if response["transaction"]["result"] == "Error"
				case response["transaction"]["errorCode"]
				when "1"
					publish_message = {result: "failure", message: "При оплате вашего платежа сервисом Pay Online возникла техническая ошибка. Пожалуйста, повторите попытку позже."}
				when "2"
					publish_message = {result: "failure", message: "Платеж по вашей карте отклонен. Воспользуйтесь другой картой."}
				when "3"
					publish_message = {result: "failure", message: "Платеж по вашей карте отклонен банком-эмитентом карты. Свяжитесь с вашим банком или воспользуйтесь другой картой и повторите запрос."}
				when "4"
					if response["transaction"]["code"] == "6001"
						md = "#{response['transaction']['id']};#{response['transaction']['threedSecure']['pd']}"
						publish_message = {result: "3ds", ascurl: "#{response['transaction']['threedSecure']['acsurl']}", pareq: "#{response['transaction']['threedSecure']['pareq']}", md: md, termurl: "https://izkh.ru"}
					end
				else
					publish_message = {result: "failure", message: "При оплате счета произошла неизвестная ошибка."}
				end
			else
				unless response["transaction"]["result"] == "OK" || response["transaction"]["result"] == "Ok"
					case response["transaction"]["errorCode"]
					when "1"
						publish_message = {result: "failure", message: "При обработке вашего платежа сервисом Pay Online возникла техническая ошибка. Пожалуйста, повторите попытку через 10 минут."}
					when "2"
						publish_message = {result: "failure", message: "Транзакция отклонена фильтрами сервиса Pay Online, повторите попытку через сутки или попробуйте оплатить с помощью новой карты. Если вы произведете более 5 попыток неудачной оплаты до истечения суток, то вам потребуется удалить сохраненную карту и заново добавить ее, как новую."}
					when "3"
						publish_message = {result: "failure", message: "Платеж по вашей карте отклонен банком-эмитентом карты. Свяжитесь с вашим банком или воспользуйтесь другой картой и повторите запрос. Возможен повтор попыток не более пяти раз в сутки в течение 3 дней."}
					when "4"
						publish_message = {result: "failure", message: "Платеж по вашей карте отклонен банком-эмитентом карты. Следует прекратить дальнейшие операции с данной сохраненной картой."}
					else
						publish_message = {result: "failure", message: "При оплате счета произошла неизвестная ошибка."}
					end
				else
					publish_message = {result: "success", message: "Платеж был успешно проведен. Данные поступили в обработку."}
				end
			end
		end
				

				
		client = Faye::Client.new('http://ec2-54-245-202-30.us-west-2.compute.amazonaws.com:9292/faye')
		client.publish("/server/#{auth_token}", publish_message)
	end
end
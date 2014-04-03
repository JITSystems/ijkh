class WebInterface::DeltaPaymentController < WebInterfaceController
  skip_before_filter :require_current_user
  def pay
    response = HTTParty.get( "http://cabinet.izkh.ru/delta_payment?key=#{params[:key]}").parsed_response["payment"]
    response.each { |r| @amount = r['installation_payment'] + r['service_payment'] }
    @commission =Vendor.find(20).commission * 100 / @amount
  end

  def pay_online
    response = HTTParty.get( "http://cabinet.izkh.ru/delta_payment?key=#{params[:key]}").parsed_response["payment"]
    response.each { |r| @amount = r['installation_payment'] + r['service_payment'] }
    @commission = Vendor.find(20).commission * 100 / @amount
    merchant_id = '39859'
    order_id = DateTime.now.strftime("%y%m%d%H%M%S")
    amount = FloatModifier.format(FloatModifier.modify(@amount + @commission))
    currency = "RUB"
    private_security_key = '7ab9d14e-fb6b-4c78-88c2-002174a8cd88'

    po_root_url = "https://secure.payonlinesystem.com/ru/payment/"

    security_key_string ="MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&PrivateSecurityKey=#{private_security_key}"
    security_key = Digest::MD5.hexdigest(security_key_string)
    url = "#{po_root_url}?MerchantId=#{merchant_id}&OrderId=#{order_id}&Amount=#{amount}&Currency=#{currency}&SecurityKey=#{security_key}&user_id=0&ReturnURL=https%3A//izkh.ru"

    respond_to do |format|
      format.js {
         render js: "window.location.replace('#{url}');"
         # render js: "console.log('#{params}');"
      }
    end
  end
end

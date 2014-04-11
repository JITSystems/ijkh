class YandexMoneyController < ApplicationController
  skip_before_filter :require_auth_token
  after_filter do
    logger.info response.body
  end
  
  def check
    @check = YandexMoney.new(params[:requestDatetime], params[:md5], params[:orderSumCurrencyPaycash], params[:orderSumBankPaycash], params[:orderNumber], params[:customerNumber], params[:orderSumAmount], params[:invoiceId]).check
    logger.info @check
    render :template => "yandex_money/check.xml.erb", :layout => false 
  end

  def notify
    @notify = YandexMoney.new(params[:requestDatetime], params[:md5], params[:orderSumCurrencyPaycash], params[:orderSumBankPaycash], params[:orderNumber], params[:customerNumber], params[:orderSumAmount], params[:invoiceId]).notify
    logger.info @notify
    render :template => "yandex_money/notify.xml.erb", :layout => false 
  end

end

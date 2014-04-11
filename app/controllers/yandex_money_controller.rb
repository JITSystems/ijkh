class YandexMoneyController < ApplicationController
  skip_before_filter :require_auth_token
  after_filter do
    logger.info response.body
  end
  
  def check
    @check = YandexMoney.new(params[:requestDatetime], params[:md5], params[:orderSumCurrencyPaycash], params[:orderSumBankPaycash], params[:orderNumber], params[:customerNumber], params[:orderSumAmount], params[:invoiceId]).check
    logger.info @check
    render xml: "yandex_money/check"
  end

  def notify
    render :xml => YandexMoney.new(params[:requestDatetime], params[:md5], params[:orderSumCurrencyPaycash], params[:orderSumBankPaycash], params[:orderNumber], params[:customerNumber], params[:orderSumAmount], params[:invoiceId]).notify
  end

end

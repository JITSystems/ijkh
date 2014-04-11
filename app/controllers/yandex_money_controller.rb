class YandexMoneyController < ApplicationController
  skip_before_filter :require_auth_token
  
  def check
    render :xml => YandexMoney.new(params[:requestDatetime], params[:md5], params[:orderSumCurrencyPaycash], params[:orderSumBankPaycash], params[:orderNumber], params[:customerNumber], params[:orderSumAmount], params[:invoiceId]).check
  end

  def notify
    render :xml => YandexMoney.new(params[:requestDatetime], params[:md5], params[:orderSumCurrencyPaycash], params[:orderSumBankPaycash], params[:orderNumber], params[:customerNumber], params[:orderSumAmount], params[:invoiceId]).notify
  end

end

class YandexMoneyController < ApplicationController
  def notify
    render :xml => YandexMoney.new(params[:request], params[:requestDatetime], params[:md5], params[:orderNumber], params[:customerNumber], params[:orderSumAmount], params[:invoiceId]).notify
  end
end

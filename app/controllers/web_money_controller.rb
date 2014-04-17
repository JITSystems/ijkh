class WebMoneyController < ApplicationController
skip_before_filter :require_auth_token
  after_filter do
    logger.info response.body
  end

  def invoice_confirmation
    @log = WebMoney.invoice_confirmation(params[:LMI_MERCHANT_ID], params[:LMI_PAYMENT_AMOUNT], params[:ORDER_ID])
    logger.info @log
    render text: "YES"
  end

  def payment_notification
    @log = WebMoney.payment_notification(params[:LMI_MERCHANT_ID], params[:LMI_PAYMENT_NO], params[:LMI_SYS_PAYMENT_ID], params[:LMI_SYS_PAYMENT_DATE], params[:LMI_PAYMENT_AMOUNT], params[:LMI_CURRENCY], params[:LMI_PAID_AMOUNT], params[:LMI_PAID_CURRENCY], params[:LMI_PAYMENT_SYSTEM], params[:LMI_HASH], params[:ORDER_ID])
    logger.info @log 
    render text: "YES"
  end
end

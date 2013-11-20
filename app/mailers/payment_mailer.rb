class PaymentMailer < ActionMailer::Base

  default :from => "no-reply@izkh.ru"
  default :to => "434713@gmail.com"

  def new_message(message)
    @message = message
    mail(:subject => "izkh.ru #{message.subject}")
  end

end
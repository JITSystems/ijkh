class RequestForVendorMailer < ActionMailer::Base

  default :from => "no-reply@izkh.ru"
  # default :to => "john.loudless@gmail.com"


   def self.send_replacement_request(message)
     @recipients = ["feedback@izkh.ru", "karpenko@izkh.ru", "434713@gmail.com"]
     @recipients.each do |recipient|
       new_message(recipient, message).deliver
     end
   end

  def new_message(recipient, message)
    @message = message
    mail(:subject => "izkh.ru #{message.subject}", :to => "#{recipient}")
  end

end
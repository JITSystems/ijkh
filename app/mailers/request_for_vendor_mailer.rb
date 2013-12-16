class RequestForVendorMailer < ActionMailer::Base

  default :from => "no-reply@izkh.ru"
  # default :to => "john.loudless@gmail.com"


   def self.send_replacement_request(message)
     @recipients = ["john.loudless@gmail.com", "nocool@inbox.ru"]
     @recipients.each do |recipient|
       new_message(recipient, message).deliver
     end
   end

  def new_message(recipient, message)
    @message = message
    mail(:subject => "izkh.ru #{message.subject}", :to => "#{recipient}")
  end

end
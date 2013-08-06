# encoding: utf-8 

class QuizMailer < ActionMailer::Base

  default :from => "no-reply@izkh.ru"
  default :to => "feedback@izkh.ru"

  def new_message(message, user)
  	@message = message
    mail(to: user.email, subject: message.subject )
  end

end
# encoding: utf-8 

class FiModerationMailer < ActionMailer::Base

  default :from => "no-reply@izkh.ru"
  default :to => "feedback@izkh.ru"

  def new_message(message)
    @message = message
    mail(:subject => "izkh.ru #{message.subject}")
  end

	def reject(user)
		@user = user
 		mail :to => @user.email, :subject => "В регистрации объявления отказано."
 	end

end
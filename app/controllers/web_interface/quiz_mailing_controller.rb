# encoding: utf-8 

class WebInterface::QuizMailingController < WebInterfaceController

	skip_before_filter :require_current_user

		def show
			@user = User.select("id, email, first_name")
			@message = Message.new
		end

	 def create
	    
	  	@user = User.select("id, email, first_name")

	  	@user.each do |user|

		  	message_params = {
				subject: 		"testy",
				body: 			"Lorem ipsum dolor.",
				email: 			user.email,
				name: 			user.first_name
			}

		   	@message = Message.new(message_params)

		    #QuizMailer.new_message(@message, user).deliver

		    if @message.valid?
		      QuizMailer.new_message(@message, user).deliver
		    else
		      flash.now.alert = "Всё плохо."
		      render :show
		    end

	   	end

	 end

end
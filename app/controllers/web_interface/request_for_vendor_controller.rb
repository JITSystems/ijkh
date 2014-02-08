# encoding: utf-8 

class WebInterface::RequestForVendorController < WebInterfaceController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    
    if @message.valid?
     	# RequestForVendorMailer.new_message(@message).deliver
     	RequestForVendorMailer.send_replacement_request(@message)
      redirect_to(main_path, :notice => "Ваше сообщение успешно отправлено.")
    else
      flash.now.alert = "Пожалуйста, заполните все поля."
      render :new
    end
  end

end
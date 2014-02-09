# encoding: utf-8 

class WebInterface::RequestForVendorController < WebInterfaceController

  def new
    # match 'request_for_vendor' => 'web_interface/request_for_vendor#new', :as => 'request_for_vendor', :via => :get
      
    @message = Message.new
  end

  def create
    # match 'request_for_vendor' => 'web_interface/request_for_vendor#create', :as => 'request_for_vendor', :via => :post
    
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
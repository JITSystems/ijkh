# encoding: utf-8 

class WebInterface::FeedbackController < WebInterfaceController

  def new
    # match 'feedback' => 'web_interface/feedback#new', :as => 'feedback', :via => :get
    @message = Message.new
  end

  def create
    # match 'feedback' => 'web_interface/feedback#create', :as => 'feedback', :via => :post
    @message = Message.new(params[:message])
    
    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      redirect_to(main_path, :notice => "Ваше сообщение успешно отправлено.")
    else
      flash.now.alert = "Пожалуйста, заполните все поля."
      render :new
    end
  end

end
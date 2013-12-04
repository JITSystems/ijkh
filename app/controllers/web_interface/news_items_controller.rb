# encoding: utf-8

class WebInterface::NewsItemsController < WebInterfaceController
  layout 'title_page'
	skip_before_filter :require_current_user

  before_filter :get_statistics

  def get_statistics
    @users = User.all.count
      @vendors = Vendor.where(is_active: true).count
  end


  # http_basic_authenticate_with name: "root", password: "123qweasdzxc", :except => :show


  def index
    @news = WebInterface::NewsItem.all  
  end

  
  def show
      @news_item = WebInterface::NewsItem.find(params[:id])
  end


  def new
    @news_item = WebInterface::NewsItem.new
  end


  def create
    @news_item = WebInterface::NewsItem.create(params[:web_interface_news_item])

    if @news_item.save 
      redirect_to :action => :show, :id => @news_item.id, :create => true
    end 
  end


  def edit
    @news_item = WebInterface::NewsItem.find(params[:id])
  end


  def update
    @news_item = WebInterface::NewsItem.find(params[:id])

    if @news_item.update_attributes(params[:web_interface_news_item])
      redirect_to :action => :show, :id => @news_item.id
    end 
  end


  def destroy
    @news_item = WebInterface::NewsItem.find(params[:id])

    @news_item.destroy
  end


end

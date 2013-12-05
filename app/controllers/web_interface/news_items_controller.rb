# encoding: utf-8

class WebInterface::NewsItemsController < WebInterfaceController
  layout 'title_page'
	skip_before_filter :require_current_user

  before_filter :get_statistics

  before_filter :check_users, :except => :show, :except => :index

  def get_statistics
      @users = User.all.count
      @vendors = Vendor.where(is_active: true).count
  end

  def check_users
      unless [16,12,62,120,2,6].include? current_user.id
        redirect_to :action => :index
      end 
  end


  # http_basic_authenticate_with name: "root", password: "123qweasdzxc", :except => :show


  def index
    @news = WebInterface::NewsItem.order('created_at desc')
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

    redirect_to :action => :index
  end


end

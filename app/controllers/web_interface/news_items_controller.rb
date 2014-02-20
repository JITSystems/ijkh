# encoding: utf-8

class WebInterface::NewsItemsController < WebInterfaceController
  layout 'title_page'
	skip_before_filter :require_current_user

  before_filter :get_statistics
  before_filter :get_freelancers

  before_filter :check_users, :except => [:index, :show]

  def get_statistics
      @users = User.all.count
      @vendors = Vendor.where(is_active: true).count
  end

  def check_users
    unless current_user
      current_user_id = 0
    else
      current_user_id = current_user.id
    end


    unless [16,12,62,120,2,6,630,930].include? current_user_id
      redirect_to :action => :index
    end 
  end

  def insert_news
      # load the gem
      require 'csv'

      @worksheet = []
      CSV.foreach("public/files/111.csv") do |row|
        @worksheet << row
      end

  end


   def public_all_news
      require 'csv'

      @worksheet = []
      CSV.foreach("public/files/111.csv") do |row|
        @worksheet << row
      end

      WebInterface::NewsItem.delete_all

      is_company = true
      body = ''
      title = ''

      @worksheet.each do |w|

        if w[1] == 'TRUE'
          is_company = true
        else
          is_company = false
        end

        title = w[3]
        body = w[4]

        if w[2] != '' && w[2]
          body += '<img src="' + w[2] + '" />'
        end

        WebInterface::NewsItem.create!(title: title, body: body, is_company: is_company )
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

class AddIsCompanyFieldToNewsItems < ActiveRecord::Migration
  def change
  	 add_column :web_interface_news_items, :is_company, :boolean
  end
end

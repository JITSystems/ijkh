class CreateWebInterfaceNewsItems < ActiveRecord::Migration
  def change
    create_table :web_interface_news_items do |t|
      t.string :title
      t.text :body
      t.string :date
      t.boolean :published

      t.timestamps
    end
  end
end

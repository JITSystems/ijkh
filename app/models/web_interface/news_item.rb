class WebInterface::NewsItem < ActiveRecord::Base
  attr_accessible :body, :date, :published, :title, :is_company

   validates_presence_of :body, :title
end

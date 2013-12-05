class WebInterface::NewsItem < ActiveRecord::Base
  attr_accessible :body, :date, :published, :title, :is_company
end

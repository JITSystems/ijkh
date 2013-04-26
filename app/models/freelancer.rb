class Freelancer < ActiveRecord::Base
  attr_accessible :freelance_category_id, :description, :phone, :picture_url, :title, :work_time

  belongs_to :freelance_category
end

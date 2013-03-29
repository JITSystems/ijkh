class FreelanceCategory < ActiveRecord::Base
  attr_accessible :description, :title

  has_many :freelancers, select: 'id, title, phone, work_time, description, picture_url, freelance_category_id'
end

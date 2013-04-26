class FreelanceCategory < ActiveRecord::Base
  attr_accessible :description, :title

  has_many :freelancers
end

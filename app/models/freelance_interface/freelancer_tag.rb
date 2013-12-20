class FreelanceInterface::FreelancerTag < ActiveRecord::Base
  attr_accessible :freelancer_id, :tag_id

  belongs_to :tag
  belongs_to :freelancer
end

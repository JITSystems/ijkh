class FreelanceInterface::TopTenFreelancer < ActiveRecord::Base
  attr_accessible :freelancer_id, :unpublish_at

  belongs_to :freelancer
end

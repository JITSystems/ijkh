class FreelanceInterface::TopFourFreelancer < ActiveRecord::Base
  attr_accessible :freelancer_id, :tag_id, :unpublish_at

  belongs_to :freelancer
end

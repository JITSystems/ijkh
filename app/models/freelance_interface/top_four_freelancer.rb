class FreelanceInterface::TopFourFreelancer < ActiveRecord::Base
  attr_accessible :freelancer_id, :tag_id, :unpublish_at, :number_of_month, :recipe_id

  belongs_to :freelancer
  belongs_to :recipe
end

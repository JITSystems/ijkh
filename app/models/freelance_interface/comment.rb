class FreelanceInterface::Comment < ActiveRecord::Base
  attr_accessible :body, :freelancer_id, :published, :raiting

  belongs_to :freelancer
end

class FreelanceCategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description
  
  has_many :freelancers, key: :freelancer
end

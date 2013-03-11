class FreelancerSerializer < ActiveModel::Serializer
  attributes :id, :title, :work_time, :description, :picture_url, :phone
  
end

class NonUtilityServiceTypeSerializer < ActiveModel::Serializer
  attributes :id, :title

  has_many :non_utility_vendors

end

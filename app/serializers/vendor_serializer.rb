class VendorSerializer < ActiveModel::Serializer
  attributes :id, :title

  has_many :tariffs, polymorphic: true
  
end

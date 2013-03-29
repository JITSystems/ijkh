class PlaceSerializer < ActiveModel::Serializer
  attributes :id, :title, :city, :street, :apartment, :building

  has_many :services, serializer: ServiceSerializer, key: :service
end

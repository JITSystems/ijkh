class PlaceSerializer < ActiveModel::Serializer
  attributes :id, :title, :city, :street, :apartment

  has_many :services, serializer: ServiceSerializer, key: :service
end

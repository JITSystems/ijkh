class VendorSerializer < ActiveModel::Serializer
  attributes :id, :title

has_many :tariffs, serializer: TariffSerializer

end

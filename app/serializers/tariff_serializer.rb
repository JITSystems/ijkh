class TariffSerializer < ActiveModel::Serializer
  attributes :id, :title

  has_one :tariff_template, serializer: TariffTemplateSerializer

end

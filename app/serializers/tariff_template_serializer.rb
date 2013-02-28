class TariffTemplateSerializer < ActiveModel::Serializer
  attributes :id, :title

  has_many :field_templates, serializer: FieldTemplateSerializer

end

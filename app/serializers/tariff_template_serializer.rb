class TariffTemplateSerializer < ActiveModel::Serializer
  attributes :id, :title, :has_readings

  has_many :field_templates, serializer: FieldTemplateSerializer

end

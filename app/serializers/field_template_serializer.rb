class FieldTemplateSerializer < ActiveModel::Serializer
  attributes :id, :title, :tariff_template_id, :field_type

  has_many :values, serializer: ValueSerializer, key: :value
end

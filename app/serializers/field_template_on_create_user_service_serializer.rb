class FieldTemplateOnCreateUserServiceSerializer < ActiveModel::Serializer
  attributes :id, :title, :tariff_template_id, :field_type, :value

  has_many :field_template_list_values

  def value
  	{"value" => 0}
  end
end

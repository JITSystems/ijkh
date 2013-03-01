class TariffTemplateOnCreateUserServiceSerializer < ActiveModel::Serializer
	attributes :id, :title

	has_many :field_templates, serializer: FieldTemplateOnCreateUserServiceSerializer
end
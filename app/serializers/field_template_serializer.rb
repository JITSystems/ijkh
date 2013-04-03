class FieldTemplateSerializer < ActiveModel::Serializer
	attributes :id, :title, :tariff_template_id, :field_type, :is_for_calc

	has_many :values, serializer: ValueSerializer, key: :value
	has_many :field_template_list_values
	
end

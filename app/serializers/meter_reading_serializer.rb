class MeterReadingSerializer < ActiveModel::Serializer
	attributes :id, :created_at, :reading, :value_id, :field_template_id
end

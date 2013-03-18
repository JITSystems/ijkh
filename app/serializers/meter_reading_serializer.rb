class MeterReadingSerializer < ActiveModel::Serializer
	attributes :id, :created_at, :reading
end

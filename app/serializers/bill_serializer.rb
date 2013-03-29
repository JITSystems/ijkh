class BillSerializer < ActiveModel::Serializer
	attributes :id, :amount, :place_id, :service_id, :created_at
end
class ServiceSerializer < ActiveModel::Serializer
	attributes :id, :title, :place_id, :service_type_id, :tariff_id, :user_account

	has_one :tariff, serializer: TariffSerializer
	has_one :vendor, serializer: VendorUnpackedSerializer
end
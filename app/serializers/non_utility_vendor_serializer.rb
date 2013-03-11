class NonUtilityVendorSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :address, :work_time, :phone, :picture_url

  has_many :non_utility_vendor_map_positions
  has_many :non_utility_tariffs
end

class Vendor < ActiveRecord::Base
	extend VendorsRepository

  attr_accessible :service_type_id, :title, :merchant_id, :is_active, :psk, :commission, :is_integrated

  belongs_to :service_type, foreign_key: :service_type_id, select: 'id, title'

  has_many :tariff_templates, select: 'id, title, has_readings, vendor_id'
  has_many :services, select: 'id, title, vendor_id, is_active'
  has_many :tariffs, as: :owner, select: 'id, title, owner_id, owner_type, tariff_template_id'

end
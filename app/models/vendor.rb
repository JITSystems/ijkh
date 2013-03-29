class Vendor < ActiveRecord::Base
	extend VendorsRepository

  attr_accessible :service_type_id, :title

  belongs_to :service_type, foreign_key: :service_type_id, select: 'id, title'

  has_many :services, select: 'id, title, vendor_id'
  has_many :tariffs, as: :owner, select: 'id, title, owner_id, owner_type, tariff_template_id'

end

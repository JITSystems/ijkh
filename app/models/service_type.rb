class ServiceType < ActiveRecord::Base
	extend ServiceTypesRepository

  attr_accessible :title

  has_many :vendors, select: 'id, title, service_type_id, merchant_id, is_active, commission, is_integrated, inn, regexp'
  has_many :tariff_templates, select: 'id, title, service_type_id, has_readings'

end

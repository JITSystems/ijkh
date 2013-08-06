class TariffTemplate < ActiveRecord::Base

  attr_accessible :service_type_id, :title, :has_readings, :vendor_id

  belongs_to :service_type, foreign_key: :service_type_id
  belongs_to :vendor
  
  has_many :field_templates, select: "id, title, tariff_template_id, is_for_calc, field_type, value, reading_field_title, field_units"
  
end

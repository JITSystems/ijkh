class TariffTemplate < ActiveRecord::Base

  attr_accessible :service_type_id, :title

  belongs_to :service_type, foreign_key: :tariff_template_id

  has_many :tariffs, select: "id, title, tariff_template_id, owner_type, owner_id"
  has_many :field_templates, select: "id, title, tariff_template_id, is_for_calc, field_type"
  
end

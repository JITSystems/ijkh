class TariffTemplate < ActiveRecord::Base

  attr_accessible :service_type_id, :title

  belongs_to :service_type, foreign_key: :tariff_template_id

  has_many :tariffs
  has_many :field_templates
  
end

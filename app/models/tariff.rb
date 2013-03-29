class Tariff < ActiveRecord::Base
  attr_accessible :owner_id, :owner_type, :tariff_template_id, :title

  belongs_to :tariff_template, foreign_key: :tariff_template_id, select: "id, title"
  belongs_to :owner, polymorphic: true

  has_one :service
  
  has_many :values
  has_many :field_templates, through: :values
  has_many :meter_readings

   def active_model_serializer
    TariffSerializer
  end
end

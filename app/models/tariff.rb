class Tariff < ActiveRecord::Base
  attr_accessible :owner_id, :owner_type, :tariff_template_id, :title, :has_readings, :service_type_id, :service_id

  belongs_to :owner, polymorphic: true

  belongs_to :service
  
  has_many :fields
  has_many :values
  has_many :meter_readings

end

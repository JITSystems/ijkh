class Tariff < ActiveRecord::Base
  attr_accessible :owner_id, :owner_type, :tariff_template_id, :title

  belongs_to :owner, polymorphic: true

  has_one :service
  
  has_many :fields
  has_many :values
  has_many :meter_readings

end

class Value < ActiveRecord::Base
	extend ValuesRepository
	
  attr_accessible :field_template_id, :tariff_id, :value

  belongs_to :field_template, foreign_key: :field_template_id
  belongs_to :tariff, foreign_key: :tariff_id

  has_one :meter_reading
end

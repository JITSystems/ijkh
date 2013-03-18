class FieldTemplate < ActiveRecord::Base

  attr_accessible :field_type, :tariff_template_id, :title, :is_for_calc

  belongs_to :tariff_template, foreign_key: :tariff_template_id

  has_one :reading_field_template
  has_many :field_template_list_values

  has_many :values
  has_many :tariffs, through: :values
  has_many :meter_readings
end

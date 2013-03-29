class FieldTemplate < ActiveRecord::Base

  attr_accessible :field_type, :tariff_template_id, :title, :is_for_calc

  belongs_to :tariff_template, foreign_key: :tariff_template_id

  has_one :reading_field_template, select: 'id, field_template_id, title'
  has_many :field_template_list_values, select: 'id, field_template_id, value'
  has_many :values, select: 'id, field_template_id, value, tariff_id'
  has_many :meter_readings, select: 'id, field_template_id, reading, is_init'
end

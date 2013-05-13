class FieldTemplate < ActiveRecord::Base

  attr_accessible :field_type, :tariff_template_id, :title, :is_for_calc, :value, :reading_field_title, :field_units

  belongs_to :tariff_template, foreign_key: :tariff_template_id

  has_one :reading_field_template, select: 'id, field_template_id, title'
  has_many :field_template_list_values, select: 'id, field_template_id, value'
  has_many :meter_readings, select: 'id, field_template_id, reading, is_init, tariff_id, value_id, created_at, user_id'
end

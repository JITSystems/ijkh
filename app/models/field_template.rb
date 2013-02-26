class FieldTemplate < ActiveRecord::Base

  attr_accessible :field_type, :tariff_template_id, :title

  belongs_to :tariff_template, foreign_key: :tariff_template_id

  has_many :field_template_list_values

  has_many :values
  has_many :tariffs, through: :values
end

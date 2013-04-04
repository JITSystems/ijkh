class MeterReading < ActiveRecord::Base
	extend MeterReadingsRepository

  attr_accessible :reading, :tariff_id, :user_id, :value_id, :field_template_id, :is_init, :snapshot_url

  belongs_to :field_template, foreign_key: :field_template_id
  belongs_to :tariff, foreign_key: :tariff_id
  belongs_to :user, foreign_key: :user_id
  belongs_to :value, foreign_key: :value_id
end

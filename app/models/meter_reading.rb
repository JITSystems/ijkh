class MeterReading < ActiveRecord::Base
	extend MeterReadingsRepository

  attr_accessible :reading, :user_id, :field_id, :is_init, :snapshot_url, :service_id

  belongs_to :user, foreign_key: :user_id
  belongs_to :field, foreign_key: :field_id

  def last
  	order('created_at DESC').limit(1)
  end
end

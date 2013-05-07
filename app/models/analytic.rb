class Analytic < ActiveRecord::Base
	extend AnalyticsRepository

  attr_accessible :amount, :place_id, :place_title, :service_id, :service_title, :tariff_title, :user_id

  belongs_to :place
  belongs_to :service
end

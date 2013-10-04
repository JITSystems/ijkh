class Service < ActiveRecord::Base
	extend ServicesRepository
	
  attr_accessible :tariff_id, :title, :user_id, :place_id, :service_type_id, :vendor_id, :user_account, :is_active

  has_one :tariff
  has_one :account
  has_many :meter_readings
  has_many :recipes
  has_many :payment_histories
  has_many :analytics

  belongs_to :user, foreign_key: :user_id
  belongs_to :place, foreign_key: :place_id, select: 'id, title, city, street, building, apartment'
  belongs_to :vendor, foreign_key: :vendor_id, select: 'id, title, merchant_id, is_active, psk, inn'

end

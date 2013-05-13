class Account < ActiveRecord::Base
	extend AccountsRepository

  	attr_accessible :amount, :service_id, :user_id, :place_id, :status, :service_type_title, :place_title, :tariff_title, :vendor_title

  	has_many :recipes

	belongs_to :user, foreign_key: :user_id
	belongs_to :place, foreign_key: :place_id
	belongs_to :service, foreign_key: :service_id
end

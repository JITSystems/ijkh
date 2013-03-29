class Bill < ActiveRecord::Base
	extend BillsRepository

  	attr_accessible :amount, :is_paid, :service_id, :user_id, :place_id
	
	belongs_to :user, foreign_key: :user_id
	belongs_to :service, foreign_key: :service_id
	belongs_to :place, foreign_key: :place_id
end

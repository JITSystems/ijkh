class Bill < ActiveRecord::Base
  attr_accessible :amount, :is_paid, :service_id, :user_id

  belongs_to :user, foreign_key: :user_id
  belongs_to :service, foreign_key: :service_id
end

class Vendor < ActiveRecord::Base
	scope :with_tariffs, includes(:tariffs)

  attr_accessible :service_type_id, :title

  belongs_to :service_type, foreign_key: :service_type_id

  has_many :tariffs, as: :owner
end

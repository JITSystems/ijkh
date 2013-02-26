class Place < ActiveRecord::Base
  attr_accessible :apartment, :building, :city, :is_active, :street, :title, :user_id

  belongs_to :user, foreign_key: :user_id

  has_many :services
end

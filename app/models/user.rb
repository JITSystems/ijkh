class User < ActiveRecord::Base  
  # Include default devise modules. Others available are:
  # :confirmable, :recoverable,
  # :lockable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable, :token_authenticatable, :recoverable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me, :authentication_token, :first_name, :phone_number, :ios_device_token, :ios_device_status
  # attr_accessible :title, :body

  symbolize :ios_device_status, in: [:active, :inactive], allow_nil: true

  before_create :set_authentication_token

  def set_authentication_token
    ensure_authentication_token
  end

  def register_ios_device(device_token)
    update_attributes!(
      ios_device_token: device_token,
      ios_device_status: :active
    )
  end

  has_many :cards
  has_many :accounts
  has_many :payment_histories
  has_many :places, select: 'id, title, city, street, building, apartment, user_id, city_id'
  has_many :services, select: 'id, title, user_id'
  has_many :meter_readings
  has_many :tariffs, as: :owner
  has_many :recipes
  has_one :freelance_interface_freelancer
end

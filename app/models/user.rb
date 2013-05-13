class User < ActiveRecord::Base  
  # Include default devise modules. Others available are:
  # :confirmable, :recoverable,
  # :lockable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable, 
         :timeoutable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me, :authentication_token, :first_name, :phone_number
  # attr_accessible :title, :body

  before_create :set_authentication_token

  def set_authentication_token
    ensure_authentication_token
  end

  has_many :cards
  has_many :accounts
  has_many :payment_histories
  has_many :places, select: 'id, title, city, street, building, apartment, user_id'
  has_many :services, select: 'id, title, user_id'
  has_many :meter_readings
  has_many :tariffs, as: :owner
  has_many :recipes
end

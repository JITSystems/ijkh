class Recipe < ActiveRecord::Base
	extend RecipesRepository
  attr_accessible :amount, :currency, :po_tax, :service_tax, :total, :service_id, :user_id, :account_id

  belongs_to :user
  belongs_to :service
  belongs_to :account

end

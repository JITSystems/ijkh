class RecipeManager < ObjectManager
  
  def initialize(commission_type=CommissionManager.new)
    @commission_type = commission_type
  end

  def create(service, amount)
    account = service.account
    user = service.user
    currency = "RUB"

    recipe_params = {
                    amount:     amount,
                    service_id: service.id,
                    account_id: account.id,
                    user_id:    user.id,
                    currency:   currency
                    }

    commission = calculate_commission(amount)
    recipe_params.merge!(service_tax: commission[:service_tax], po_tax: commission[:po_tax], total: commission[:total])
    recipe = Recipe.create!(recipe_params)
    return recipe
  end

  def self.show_last(user, service_id)
  	Recipe.where("user_id = ? and service_id = ?", user.id, service_id).order('created_at DESC').limit(1).first
  end

protected

  def calculate_commission(amount)
  	@commission_type.calculate(amount)
  end
    
end
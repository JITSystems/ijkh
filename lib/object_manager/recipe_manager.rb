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

    if service.vendor_id
      commission = calculate_commission(amount, VendorManager.get(service.vendor_id).commission)
    else
      commission = calculate_commission(amount)
    end

      recipe_params.merge!(service_tax: commission[:service_tax], po_tax: commission[:po_tax], total: commission[:total])
      recipe = Recipe.create!(recipe_params)
    return recipe
  end

  def self.show_last(user, service_id)
  	p_h = PaymentHistory.where("user_id = ? and service_id = ? and status = 1", user.id, service_id).order('created_at DESC').limit(1).first
    self.get(p_h.recipe_id)
  end

protected

  def calculate_commission(amount, commission=0.0)
  	@commission_type.calculate(amount, commission)
  end
    
end
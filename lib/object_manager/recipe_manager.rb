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
      #<Recipe id: 1229, amount: 700.0, total: 721.0, po_tax: 0.0, service_tax: 21.0, currency: "RUB", created_at: "2013-10-21 11:05:07", updated_at: "2013-10-21 11:05:07", service_id: 42, user_id: 13, account_id: 36> 
      recipe_hash = {
        id: recipe.id,
        amount: FloatModifier.format(recipe.amount),
        total: FloatModifier.format(recipe.total),
        po_tax: FloatModifier.format(recipe.po_tax),
        service_tax: FloatModifier.format(recipe.service_tax),
        created_at: recipe.created_at,
        updated_at: recipe.updated_at,
        service_id: recipe.service_id,
        currency: recipe.currency,
        account_id: recipe.account_id,
        user_id: recipe.user_id
      }
    return recipe_hash
  end

  def self.show_last(user, service_id)
  	p_h = PaymentHistory.where("user_id = ? and service_id = ? and status = 1", user.id, service_id).order('created_at DESC').limit(1).first
    if p_h
      self.get(p_h.recipe_id)
    else
      []
    end

  end

protected

  def calculate_commission(amount, commission=0.0)
  	@commission_type.calculate(amount, commission)
  end
    
end
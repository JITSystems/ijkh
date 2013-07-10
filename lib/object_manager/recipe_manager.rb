class RecipeManager < ObjectManager
  
  def initialize(commission_type=CommissionManager.new)
    @commission_type = commission_type
  end

  def create(user, params)
    # Params hash contains: amount, service_id, account_id
    recipe_params = RecipeParams.create(user,params)
    commission = calculate_commission(params)
    recipe_params.merge!(service_tax: commission[:service_tax], po_tax: commission[:po_tax], total: commission[:total])
    recipe = Recipe.create!(recipe_params)
    recipe
  end

  def show_last(user, service_id)
  	Recipe.where("user_id = ? and service_id = ?", user.id, service_id).order('created_at DESC').limit(1).first
  end



protected

  def self.calculate_commission(params)
  	@commission_type.calculate(params[:amount])
  end
    
end
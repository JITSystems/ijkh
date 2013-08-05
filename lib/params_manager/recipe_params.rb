class RecipeParams < ParamsManager
  def self.create(user, params)
  	curency = "RUB"
  	recipe_params = {
  					 amount: params[:amount],
					 service_id: params[:service_id],
					 account_id: params[:account_id],
					 user_id: user.id,
			   		 currency: currency
  					}
  end
end
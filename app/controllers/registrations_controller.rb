class RegistrationsController < Devise::RegistrationsController
	def create
    	user = User.new(params[:user])
    	if user.save
      		render json: {user: 
                      {auth_token: user.authentication_token, 
      								email: user.email, 
      								first_name: user.first_name, 
      								last_name: user.last_name}}, status: 201
      		return
    	else
      		warden.custom_failure!
      		render :json=> user.errors, status: 422
    	end
	end	
end

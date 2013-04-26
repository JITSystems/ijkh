 class ServiceController < ApplicationController
	def index
		#@services = Service.by_user_and_place(current_user, params[:place_id])
		@services = Service.where("user_id=? and place_id=?", current_user.id, params[:place_id])
		render 'service/index'
	end

	def create
		@service = Service.create_service current_user, params
		render 'service/show'
	end


	def update_user_service
		@service = Service.update_user_service params
		render 'service/show'
	end

	def show
		@service = Service.find(params[:service_id])
		render 'service/show'
	end

	def destroy
		@service = Service.destroy_with_dependencies params[:service_id]
		render json: @service
	end

end
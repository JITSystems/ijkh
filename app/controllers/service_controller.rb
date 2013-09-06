 class ServiceController < ApplicationController
	def index
		@services = ServiceManager.index_by_place(PlaceManager.get(params[:place_id]))
		render 'service/index'
	end

	def create
		@service = Service.create_service current_user, params
		#@service = ServiceManager.create(params, current_user)
		render 'service/show'
	end


	def update_user_service
		@service = Service.update_user_service params
		render 'service/show'
	end

	def show
		@service = ServiceManager.get(params[:service_id])
		render 'service/show'
	end

	def destroy
		ServiceManager.deactivate(params[:service_id])
		render json: {status: "deleted"}
	end

	def index_user_account
  		services = Service.where("vendor_id = ? and is_active = true", params[:vendor_id]).pluck(:user_account)
  		render json: services
  	end

end
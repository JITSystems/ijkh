 class ServiceController < ApplicationController
	def index
		# GET api/1.0/place/:place_id/services
		@services = ServiceManager.index_by_place(PlaceManager.get(params[:place_id]))
		render 'service/index'
	end

	def create
		# POST api/1.0/place/:place_id/service
		@service = ServiceManger.create(params, current_user)
		render 'service/show'
	end


	def update_user_service
		# PUT api/1.0/userservice/:service_id
		@service = ServiceManager.update_user_service(params)
		render 'service/show'
	end

	def show
		# GET api/1.0/service/:service_id
		@service = ServiceManager.get(params[:service_id])
		render 'service/show'
	end

	def destroy
		# DELETE api/1.0/service/:service_id
		ServiceManager.deactivate(params[:service_id])
		render json: {status: "deleted"}
	end

	def index_user_account
		# GET api/1.0/user_accounts/:vendor_id
  		@services = ServiceManager.index_user_account(params[:vendor_id])
  		render json: @services
  	end

end
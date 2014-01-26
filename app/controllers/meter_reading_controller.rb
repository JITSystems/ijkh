class MeterReadingController < ApplicationController
	skip_before_filter :require_auth_token
	def index
		# GET api/1.0/tariff/:tariff_id/meterreadings
		@meter_readings = MeterReadingManager.get_by_tariff(TariffManager.get(params[:tariff_id]))
		render 'meter_reading/index'
	end

	def index_by_vendor
		# GET api/1.0/meterreadings
		meter_readings = MeterReadingManager.index_by_vendor(params[:meter_reading][:month], params[:meter_reading][:vendor_id])
		render json: {meter_reading: meter_readings}
	end

	def create
		# POST api/1.0/meterreading
		@meter_reading = MeterReadingManager.create(current_user, params)
		render 'meter_reading/show'
	end

	def show_last
		# GET api/1.0/meterreading/last
		@meter_reading = MeterReadingManager.get_last(params[:field_id])
		render 'meter_reading/show_last'
	end

	def reset
		# DELETE api/1.0/meter_reading/reset
		# service_id, auth_token
		MeterReadingManager.reset(params, current_user)
		render json: {status: "success"}
	end

	def create_init
		# POST api/1.0/meter_reading/create_init
		# reading, field_id, service_id, auth_token
		@meter_reading = MeterReadingManager.create_init(params, current_user)
		render 'meter_reading/show'
	end

	def delete_last
		# DELETE api/1.0/meter_reading/delete_last
		# service_id, field_id, auth_token
		MeterReadingManager.delete_last(params, current_user)
		@meter_reading = MeterReadingManager.get_last(params[:field_id])
		render 'meter_reading/show_last'
	end
end
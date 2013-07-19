class MeterReadingController < ApplicationController
	skip_before_filter :require_auth_token
	def index
		@meter_readings = MeterReading.by_tariff(params[:tariff_id])
		render 'meter_reading/index'
	end

	def index_by_vendor
		@month = params[:meter_reading][:month]
		@meter_readings = MeterReading.where("extract(month from created_at) = ?", @month)
		render json: {meter_reading: @meter_readings}
	end

	def create
		# params :
		# => service_id
		# => place_id
		# => prev_reading
		# => meter_reading :
		# 	=> id
		# 	=> field_id
		# 	=> reading
		# 	=> snapshot_url
		@meter_reading = MeterReading.new_meter_reading current_user, params
		render 'meter_reading/show'
	end

	def show_last
		@meter_reading = MeterReading.where(field_id: params[:field_id]).order("created_at DESC").limit(1)
		render 'meter_reading/show_last'
	end


end
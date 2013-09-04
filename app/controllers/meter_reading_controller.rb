class MeterReadingController < ApplicationController
	skip_before_filter :require_auth_token
	def index
		@meter_readings = MeterReadingManager.get_by_tariff(TariffManager.get(params[:tariff_id]))
		render 'meter_reading/index'
	end

	def index_by_vendor
		@month = params[:meter_reading][:month]
		@vendor = params[:meter_reading][:vendor_id]
		@meter_readings = MeterReading.where("vendor_id and extract(month from created_at) = ?", @vendor, @month)
		render json: {meter_reading: @meter_readings}
	end

	def create
		@meter_reading = MeterReadingManager.create(current_user, params)
		render 'meter_reading/show'
	end

	def show_last
		@meter_reading = MeterReadingManager.get_last(params[:field_id])
		render 'meter_reading/show_last'
	end


end